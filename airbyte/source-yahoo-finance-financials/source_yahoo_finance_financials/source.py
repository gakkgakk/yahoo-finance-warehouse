from typing import Any, Mapping, Tuple, Optional, List
import logging

import requests

from airbyte_cdk.sources import AbstractSource
from airbyte_cdk.sources.streams import Stream
from airbyte_cdk.sources.streams.http.auth import NoAuth

from .streams import BalanceStatement
from .streams import IncomeStatement
from .streams import CashflowStatement
from source_yahoo_finance_financials.streams.company import Company
from source_yahoo_finance_financials.streams.ownership import Ownership
from .streams.constants import BROWSER_HEADERS


class SourceYahooFinancials(AbstractSource):
    def check_connection(
        self, logger: logging.Logger, config: Mapping[str, Any]
    ) -> Tuple[bool, Optional[Any]]:
        tickers = config["tickers"]

        if len(tickers) == 0:
            return False, "No tickers provided monsieur?"

        for ticker in tickers:
            # Check that yahoo finance has the ticker
            response = requests.get(
                url=f"https://query1.finance.yahoo.com/v6/finance/autocomplete?query={ticker}&lang=en",
                headers=BROWSER_HEADERS,
            )
            if response.status_code != 200:
                return False, f"Ticker {ticker} not found"
            response_json = response.json()
            if "ResultSet" not in response_json:
                return False, f"Invalid check response format for ticker {ticker}"
            if "Result" not in response_json["ResultSet"]:
                return False, f"Invalid check response format for ticker {ticker}"
            if len(response_json["ResultSet"]["Result"]) == 0:
                return False, f"Ticker {ticker} not found"

        return True, None

    def streams(self, config: Mapping[str, Any]) -> List[Stream]:
        args = {
            "tickers": config["tickers"],
        }

        auth = NoAuth()

        return [
            IncomeStatement(authenticator=auth, **args),
            BalanceStatement(authenticator=auth, **args),
            CashflowStatement(authenticator=auth, **args),
            Company(authenticator=auth, **args),
            Ownership(authenticator=auth, **args),
        ]
