from typing import Any, Mapping, Iterable

import requests

from .abstract_financial_stream import AbstractFinancialStream


class Company(AbstractFinancialStream):
    url_base = "https://query2.finance.yahoo.com/v10/finance/quoteSummary/"

    def path(
        self,
        *,
        stream_state: Mapping[str, Any] = None,
        stream_slice: Mapping[str, Any] = None,
        next_page_token: Mapping[str, Any] = None,
    ) -> str:
        next_index = next_page_token or 0

        return f"{self.tickers[next_index]}?lang=en-US&region=US&modules=assetProfile%2CsecFilings"
