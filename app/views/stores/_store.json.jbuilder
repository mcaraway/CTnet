json.extract! store, :id, :RowVersion, :License, :Edition, :TypeCode, :Enabled, :SetupComplete, :StoreName, :Company, :Street1, :Street2, :Street3, :City, :StateProvCode, :PostalCode, :CountryCode, :Phone, :Fax, :Email, :Website, :AutoDownload, :AutoDownloadMinutes, :AutoDownloadOnlyAway, :AddressValidationSetting, :ComputerDownloadPolicy, :DefaultEmailAccountID, :ManualOrderPrefix, :ManualOrderPostfix, :InitialDownloadDays, :InitialDownloadOrder, :created_at, :updated_at
json.url store_url(store, format: :json)
