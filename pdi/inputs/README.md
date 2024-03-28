# Important information on inputs

All inputs ingestion are in ``all_inputs.ktr``, with exception of the input file ``heart_rate.json``, whose input is in a separate file. The reason they are separated is due to the latter's high computational resource consumption, which may lead to freezing Pentaho DI interface.

Before running ``all_inputs.ktr``, make sure to <b>delete the first row from ``participant_overview.xslx``</b>, which does not contain data and, if kept, leads to error when reading the headers.