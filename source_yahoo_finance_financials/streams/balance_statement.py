from typing import Any, Mapping

from .abstract_financial_stream import AbstractFinancialStream

from .constants import BALANCE_TYPE_PARAMETERS


class BalanceStatement(AbstractFinancialStream):
    url_base = "https://query2.finance.yahoo.com/ws/fundamentals-timeseries/v1/finance/timeseries/"

    def path(
        self,
        *,
        stream_state: Mapping[str, Any] = None,
        stream_slice: Mapping[str, Any] = None,
        next_page_token: Mapping[str, Any] = None,
    ) -> str:
        next_index = next_page_token or 0

        annual_types = ["annual" + element for element in BALANCE_TYPE_PARAMETERS]
        quarterly_types = ["quarterly" + element for element in BALANCE_TYPE_PARAMETERS]

        type_string = "%2C".join(annual_types + quarterly_types)

        return f"{self.tickers[next_index]}?lang=en-US&region=US&type={type_string}&merge=false&period1=493590046&period2=1664481730"
