from abc import ABC
from typing import Any, Iterable, Mapping, MutableMapping, Optional

import requests

from airbyte_cdk.sources.streams.http import HttpStream


from .constants import BROWSER_HEADERS


class AbstractFinancialStream(HttpStream, ABC):
    primary_key = None

    def __init__(self, tickers, **kwargs):
        super().__init__(**kwargs)
        self.next_index = 0
        self.tickers = tickers

    def next_page_token(
        self, response: requests.Response
    ) -> Optional[Mapping[str, Any]]:
        self.next_index += 1

        if self.next_index >= len(self.tickers):
            return None

        return self.next_index

    def request_params(
        self,
        stream_state: Mapping[str, Any],
        stream_slice: Mapping[str, Any] = None,
        next_page_token: Mapping[str, Any] = None,
    ) -> MutableMapping[str, Any]:
        next_index = next_page_token or 0

        return {"symbol": self.tickers[next_index]}

    def parse_response(
        self,
        response: requests.Response,
        *,
        stream_state: Mapping[str, Any],
        stream_slice: Mapping[str, Any] = None,
        next_page_token: Mapping[str, Any] = None
    ) -> Iterable[Mapping]:
        return [response.json()]

    def parse_response(
        self,
        response: requests.Response,
        *,
        stream_state: Mapping[str, Any],
        stream_slice: Mapping[str, Any] = None,
        next_page_token: Mapping[str, Any] = None
    ) -> Iterable[Mapping]:
        response_data = response.json()

        try:
            response_data["ticker"] = self.tickers[self.next_index]
        except:
            pass

        yield response_data

    def request_headers(self, **kwargs) -> Mapping[str, Any]:
        base_headers = super().request_headers(**kwargs)

        return {**base_headers, **BROWSER_HEADERS}
