#
# Copyright (c) 2022 Airbyte, Inc., all rights reserved.
#


import sys

from airbyte_cdk.entrypoint import launch
from source_yahoo_finance_financials import (
    SourceYahooFinancials
)

if __name__ == "__main__":
    source = SourceYahooFinancials()
    launch(source, sys.argv[1:])
