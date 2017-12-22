# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "Action", primary_key: "ActionID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                      null: false
    t.string       "Name",                limit: 50,  null: false
    t.boolean      "Enabled",                         null: false
    t.integer      "ComputerLimitedType",             null: false
    t.varchar      "ComputerLimitedList", limit: 150, null: false
    t.boolean      "StoreLimited",                    null: false
    t.string       "StoreLimitedList",    limit: 150, null: false
    t.integer      "TriggerType",                     null: false
    t.string       "TriggerSettings",                 null: false
    t.string       "TaskSummary",         limit: 150, null: false
    t.varchar      "InternalOwner",       limit: 50
  end

  create_table "ActionFilterTrigger", primary_key: "ActionID", id: :bigint, force: :cascade do |t|
    t.bigint  "FilterNodeID",                    null: false
    t.integer "Direction",                       null: false
    t.integer "ComputerLimitedType",             null: false
    t.varchar "ComputerLimitedList", limit: 150, null: false
  end

  create_table "ActionQueue", primary_key: "ActionQueueID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                                                   null: false
    t.bigint       "ActionID",                                                                     null: false
    t.string       "ActionName",          limit: 50,                                               null: false
    t.integer      "ActionQueueType",                 default: 0,                                  null: false
    t.binary_basic "ActionVersion",       limit: 8,   default: "\x00\x00\x00\x00\x00\x00\x00\x00", null: false
    t.binary_basic "QueueVersion",        limit: 8,   default: "\x00\x00\x00\x00\x1D?\x96\xFB",    null: false
    t.datetime     "TriggerDate",                     default: -> { "getutcdate()" },              null: false
    t.bigint       "TriggerComputerID",                                                            null: false
    t.varchar      "ComputerLimitedList", limit: 150,                                              null: false
    t.bigint       "ObjectID"
    t.integer      "Status",                                                                       null: false
    t.integer      "NextStep",                                                                     null: false
    t.string       "ContextLock",         limit: 36
    t.string       "ExtraData"
    t.index ["ActionQueueType"], name: "IX_ActionQueue_ActionQueueType"
    t.index ["ContextLock"], name: "IX_ActionQueue_ContextLock"
    t.index ["Status", "ActionQueueType", "ActionQueueID"], name: "IX_ActionQueue_Search"
  end

  create_table "ActionQueueSelection", primary_key: "ActionQueueSelectionID", id: :bigint, force: :cascade do |t|
    t.bigint "ActionQueueID", null: false
    t.bigint "ObjectID",      null: false
    t.index ["ActionQueueID", "ObjectID"], name: "IX_ActionQueueSelection_ActionQueueID", unique: true
  end

  create_table "ActionQueueStep", primary_key: "ActionQueueStepID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                        null: false
    t.bigint       "ActionQueueID",                     null: false
    t.integer      "StepStatus",                        null: false
    t.integer      "StepIndex",                         null: false
    t.string       "StepName",              limit: 100, null: false
    t.string       "TaskIdentifier",        limit: 50,  null: false
    t.string       "TaskSettings",                      null: false
    t.integer      "InputSource",                       null: false
    t.bigint       "InputFilterNodeID",                 null: false
    t.boolean      "FilterCondition",                   null: false
    t.bigint       "FilterConditionNodeID",             null: false
    t.integer      "FlowSuccess",                       null: false
    t.integer      "FlowSkipped",                       null: false
    t.integer      "FlowError",                         null: false
    t.datetime     "AttemptDate",                       null: false
    t.string       "AttemptError",          limit: 500, null: false
    t.integer      "AttemptCount",                      null: false
    t.index ["ActionQueueID", "StepIndex"], name: "IX_ActionQueueStep_ActionQueue", unique: true
  end

  create_table "ActionTask", primary_key: "ActionTaskID", id: :bigint, force: :cascade do |t|
    t.bigint  "ActionID",                         null: false
    t.string  "TaskIdentifier",        limit: 50, null: false
    t.string  "TaskSettings",                     null: false
    t.integer "StepIndex",                        null: false
    t.integer "InputSource",                      null: false
    t.bigint  "InputFilterNodeID",                null: false
    t.boolean "FilterCondition",                  null: false
    t.bigint  "FilterConditionNodeID",            null: false
    t.integer "FlowSuccess",                      null: false
    t.integer "FlowSkipped",                      null: false
    t.integer "FlowError",                        null: false
  end

  create_table "AmazonASIN", primary_key: ["StoreID", "SKU"], force: :cascade do |t|
    t.bigint  "StoreID",                null: false
    t.varchar "SKU",        limit: 100, null: false
    t.varchar "AmazonASIN", limit: 32,  null: false
  end

  create_table "AmazonOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.varchar  "AmazonOrderID",                limit: 32,                          null: false
    t.money    "AmazonCommission",                        precision: 19, scale: 4, null: false
    t.integer  "FulfillmentChannel",                                               null: false
    t.integer  "IsPrime",                                                          null: false
    t.datetime "EarliestExpectedDeliveryDate"
    t.datetime "LatestExpectedDeliveryDate"
    t.string   "PurchaseOrderNumber",          limit: 50,                          null: false
    t.index ["AmazonOrderID"], name: "IX_Auto_AmazonOrderID"
    t.index ["EarliestExpectedDeliveryDate"], name: "IX_Auto_EarliestExpectedDeliveryDate"
    t.index ["FulfillmentChannel"], name: "IX_Auto_FulfillmentChannel"
    t.index ["IsPrime"], name: "IX_Auto_IsPrime"
    t.index ["LatestExpectedDeliveryDate"], name: "IX_Auto_LatestExpectedDeliveryDate"
  end

  create_table "AmazonOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.string "AmazonOrderItemCode", limit: 64,  null: false
    t.string "ASIN",                limit: 255, null: false
    t.string "ConditionNote",       limit: 255, null: false
  end

  create_table "AmazonProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "DimsProfileID"
    t.float   "DimsLength"
    t.float   "DimsWidth"
    t.float   "DimsHeight"
    t.float   "DimsWeight"
    t.boolean "DimsAddWeight"
    t.integer "DeliveryExperience"
    t.float   "Weight"
  end

  create_table "AmazonShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.string  "CarrierName",            limit: 50,                           default: "",    null: false
    t.string  "ShippingServiceName",    limit: 50,                           default: "",    null: false
    t.string  "ShippingServiceID",      limit: 50,                           default: "",    null: false
    t.string  "ShippingServiceOfferID", limit: 250,                          default: "",    null: false
    t.money   "InsuranceValue",                     precision: 19, scale: 4, default: 0.0,   null: false
    t.bigint  "DimsProfileID",                                               default: 0,     null: false
    t.float   "DimsLength",                                                  default: 0.0,   null: false
    t.float   "DimsWidth",                                                   default: 0.0,   null: false
    t.float   "DimsHeight",                                                  default: 0.0,   null: false
    t.float   "DimsWeight",                                                  default: 0.0,   null: false
    t.boolean "DimsAddWeight",                                               default: false, null: false
    t.integer "DeliveryExperience",                                          default: 2,     null: false
    t.money   "DeclaredValue",                      precision: 19, scale: 4
    t.string  "AmazonUniqueShipmentID", limit: 50
  end

  create_table "AmazonStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.integer    "AmazonApi",                                                                                                                         null: false
    t.char       "AmazonApiRegion",       limit: 2,                                                                                                   null: false
    t.string     "SellerCentralUsername", limit: 50,                                                                                                  null: false
    t.string     "SellerCentralPassword", limit: 50,                                                                                                  null: false
    t.varchar    "MerchantName",          limit: 64,                                                                                                  null: false
    t.varchar    "MerchantToken",         limit: 32,                                                                                                  null: false
    t.varchar    "AccessKeyID",           limit: 32,                                                                                                  null: false
    t.string     "AuthToken",             limit: 100,                                                                                                 null: false
    t.text_basic "Cookie",                limit: 2147483647,                                                                                          null: false
    t.datetime   "CookieExpires",                                                                                                                     null: false
    t.datetime   "CookieWaitUntil",                                                                                                                   null: false
    t.varbinary  "Certificate",           limit: 2048
    t.text_basic "WeightDownloads",       limit: 2147483647,                                                                                          null: false
    t.string     "MerchantID",            limit: 50,                                                                                                  null: false
    t.string     "MarketplaceID",         limit: 50,                                                                                                  null: false
    t.boolean    "ExcludeFBA",                                                                                                                        null: false
    t.string     "DomainName",            limit: 50,                                                                                                  null: false
    t.string     "AmazonShippingToken",   limit: 500,        default: "hlkH7XeEA5GehLVXyC7ZpSjpPQVzOciXTvoFKlnobEJblNvBlX/dasYvkTYKkOQfL5Oy6kfyeZI=", null: false
  end

  create_table "AmeriCommerceStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "Username",    limit: 70,  null: false
    t.string  "Password",    limit: 70,  null: false
    t.string  "StoreUrl",    limit: 350, null: false
    t.integer "StoreCode",               null: false
    t.string  "StatusCodes",             null: false
  end

  create_table "Audit", primary_key: "AuditID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                null: false
    t.bigint       "TransactionID",             null: false
    t.bigint       "UserID",                    null: false
    t.bigint       "ComputerID",                null: false
    t.integer      "Reason",                    null: false
    t.varchar      "ReasonDetail",  limit: 100
    t.datetime     "Date",                      null: false
    t.integer      "Action",                    null: false
    t.bigint       "ObjectID"
    t.boolean      "HasEvents",                 null: false
    t.index ["Action"], name: "IX_Audit_Action"
    t.index ["Date"], name: "IX_Audit_Date"
    t.index ["ObjectID"], name: "IX_Audit_ObjectIDDate"
    t.index ["TransactionID"], name: "IX_Audit_TransactionID", unique: true
  end

  create_table "AuditChange", primary_key: "AuditChangeID", id: :bigint, force: :cascade do |t|
    t.bigint  "AuditID",    null: false
    t.integer "ChangeType", null: false
    t.bigint  "ObjectID",   null: false
    t.index ["AuditID"], name: "IX_AuditChange_AuditID"
  end

  create_table "AuditChangeDetail", primary_key: "AuditChangeDetailID", id: :bigint, force: :cascade do |t|
    t.bigint  "AuditChangeID",                    null: false
    t.bigint  "AuditID",                          null: false
    t.varchar "DisplayName",   limit: 50,         null: false
    t.integer "DisplayFormat", limit: 1,          null: false
    t.integer "DataType",      limit: 1,          null: false
    t.text    "TextOld",       limit: 2147483647
    t.text    "TextNew",       limit: 2147483647
    t.string  "VariantOld"
    t.string  "VariantNew"
    t.index ["AuditChangeID"], name: "IX_AuditChangeDetail_AuditChangeID"
    t.index ["AuditID"], name: "IX_AuditChangeDetail_AuditID"
    t.index ["VariantNew"], name: "IX_AuditChangeDetail_VariantNew"
  end

  create_table "BestRateProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "DimsProfileID"
    t.float   "DimsLength"
    t.float   "DimsWidth"
    t.float   "DimsHeight"
    t.float   "DimsWeight"
    t.boolean "DimsAddWeight"
    t.float   "Weight"
    t.integer "ServiceLevel"
  end

  create_table "BestRateShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.bigint  "DimsProfileID",                                 null: false
    t.float   "DimsLength",                                    null: false
    t.float   "DimsWidth",                                     null: false
    t.float   "DimsHeight",                                    null: false
    t.float   "DimsWeight",                                    null: false
    t.boolean "DimsAddWeight",                                 null: false
    t.integer "ServiceLevel",                                  null: false
    t.money   "InsuranceValue",       precision: 19, scale: 4, null: false
    t.integer "RequestedLabelFormat",                          null: false
  end

  create_table "BigCommerceOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.bigint   "OrderAddressID",                             null: false
    t.bigint   "OrderProductID",                             null: false
    t.boolean  "IsDigitalItem",              default: false, null: false
    t.datetime "EventDate"
    t.string   "EventName",      limit: 255
  end

  create_table "BigCommerceStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "ApiUrl",                           limit: 110, null: false
    t.string  "ApiUserName",                      limit: 65,  null: false
    t.string  "ApiToken",                         limit: 100
    t.string  "StatusCodes"
    t.integer "WeightUnitOfMeasure",                          null: false
    t.integer "DownloadModifiedNumberOfDaysBack",             null: false
  end

  create_table "BuyDotComOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.bigint  "ReceiptItemID",                          null: false
    t.integer "ListingID",                              null: false
    t.money   "Shipping",      precision: 19, scale: 4, null: false
    t.money   "Tax",           precision: 19, scale: 4, null: false
    t.money   "Commission",    precision: 19, scale: 4, null: false
    t.money   "ItemFee",       precision: 19, scale: 4, null: false
  end

  create_table "BuyDotComStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string "FtpUsername", limit: 50, null: false
    t.string "FtpPassword", limit: 50, null: false
  end

  create_table "ChannelAdvisorOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.string  "CustomOrderIdentifier", limit: 50,   null: false
    t.string  "ResellerID",            limit: 80,   null: false
    t.integer "OnlineShippingStatus",               null: false
    t.integer "OnlineCheckoutStatus",               null: false
    t.integer "OnlinePaymentStatus",                null: false
    t.string  "FlagStyle",             limit: 32,   null: false
    t.string  "FlagDescription",       limit: 80,   null: false
    t.integer "FlagType",                           null: false
    t.string  "MarketplaceNames",      limit: 1024, null: false
    t.integer "IsPrime",                            null: false
    t.index ["IsPrime"], name: "IX_ChannelAdvisorOrder_IsPrime"
    t.index ["OnlineShippingStatus"], name: "IX_ChannelAdvisorOrder_OnlineShippingStatus"
  end

  create_table "ChannelAdvisorOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.string  "MarketplaceName",      limit: 50,  null: false
    t.string  "MarketplaceStoreName", limit: 100, null: false
    t.string  "MarketplaceBuyerID",   limit: 80,  null: false
    t.string  "MarketplaceSalesID",   limit: 50,  null: false
    t.string  "Classification",       limit: 30,  null: false
    t.string  "DistributionCenter",   limit: 80,  null: false
    t.string  "HarmonizedCode",       limit: 20,  null: false
    t.boolean "IsFBA",                            null: false
    t.string  "MPN",                  limit: 50,  null: false
    t.index ["Classification"], name: "IX_ChannelAdvisorOrderItem_Classification"
    t.index ["MarketplaceBuyerID"], name: "IX_ChannelAdvisorOrderItem_MarketplaceBuyerID"
    t.index ["MarketplaceName"], name: "IX_ChannelAdvisorOrderItem_MarketPlaceName"
    t.index ["MarketplaceSalesID"], name: "IX_ChannelAdvisorOrderItem_MarketplaceSalesID"
    t.index ["MarketplaceStoreName"], name: "IX_ChannelAdvisorOrderItem_MarketplaceStoreName"
  end

  create_table "ChannelAdvisorStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "AccountKey",           limit: 50,  null: false
    t.integer "ProfileID",                        null: false
    t.string  "AttributesToDownload",             null: false
    t.boolean "ConsolidatorAsUsps",               null: false
    t.string  "AmazonMerchantID",     limit: 50,  null: false
    t.string  "AmazonAuthToken",      limit: 100, null: false
    t.char    "AmazonApiRegion",      limit: 2,   null: false
    t.string  "AmazonShippingToken",  limit: 500, null: false
  end

  create_table "ClickCartProOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.varchar "ClickCartProOrderID", limit: 25, null: false
  end

  create_table "CommerceInterfaceOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.string "CommerceInterfaceOrderNumber", limit: 60, null: false
  end

  create_table "Computer", primary_key: "ComputerID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",            null: false
    t.uuid         "Identifier",            null: false
    t.string       "Name",       limit: 50, null: false
    t.index ["Identifier"], name: "UK_Computer_Identifier", unique: true
  end

  create_table "Configuration", primary_key: "ConfigurationID", id: :boolean, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                        null: false
    t.integer      "LogOnMethod",                                       null: false
    t.boolean      "AddressCasing",                                     null: false
    t.boolean      "CustomerCompareEmail",                              null: false
    t.boolean      "CustomerCompareAddress",                            null: false
    t.boolean      "CustomerUpdateBilling",                             null: false
    t.boolean      "CustomerUpdateShipping",                            null: false
    t.integer      "CustomerUpdateModifiedBilling",                     null: false
    t.integer      "CustomerUpdateModifiedShipping",                    null: false
    t.boolean      "AuditNewOrders",                                    null: false
    t.boolean      "AuditDeletedOrders",                                null: false
    t.text         "CustomerKey",                    limit: 2147483647, null: false
  end

  create_table "Customer", primary_key: "CustomerID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                             null: false
    t.string       "BillFirstName",     limit: 30,                           null: false
    t.string       "BillMiddleName",    limit: 30,                           null: false
    t.string       "BillLastName",      limit: 30,                           null: false
    t.string       "BillCompany",       limit: 60,                           null: false
    t.string       "BillStreet1",       limit: 60,                           null: false
    t.string       "BillStreet2",       limit: 60,                           null: false
    t.string       "BillStreet3",       limit: 60,                           null: false
    t.string       "BillCity",          limit: 50,                           null: false
    t.string       "BillStateProvCode", limit: 50,                           null: false
    t.string       "BillPostalCode",    limit: 20,                           null: false
    t.string       "BillCountryCode",   limit: 50,                           null: false
    t.string       "BillPhone",         limit: 25,                           null: false
    t.string       "BillFax",           limit: 35,                           null: false
    t.string       "BillEmail",         limit: 100,                          null: false
    t.string       "BillWebsite",       limit: 50,                           null: false
    t.string       "ShipFirstName",     limit: 30,                           null: false
    t.string       "ShipMiddleName",    limit: 30,                           null: false
    t.string       "ShipLastName",      limit: 30,                           null: false
    t.string       "ShipCompany",       limit: 60,                           null: false
    t.string       "ShipStreet1",       limit: 60,                           null: false
    t.string       "ShipStreet2",       limit: 60,                           null: false
    t.string       "ShipStreet3",       limit: 60,                           null: false
    t.string       "ShipCity",          limit: 50,                           null: false
    t.string       "ShipStateProvCode", limit: 50,                           null: false
    t.string       "ShipPostalCode",    limit: 20,                           null: false
    t.string       "ShipCountryCode",   limit: 50,                           null: false
    t.string       "ShipPhone",         limit: 25,                           null: false
    t.string       "ShipFax",           limit: 35,                           null: false
    t.string       "ShipEmail",         limit: 100,                          null: false
    t.string       "ShipWebsite",       limit: 50,                           null: false
    t.integer      "RollupOrderCount",                                       null: false
    t.money        "RollupOrderTotal",              precision: 19, scale: 4, null: false
    t.integer      "RollupNoteCount",                                        null: false
    t.index ["BillCompany"], name: "IX_Auto_BillCompany"
    t.index ["BillCountryCode"], name: "IX_Auto_BillCountryCode"
    t.index ["BillEmail"], name: "IX_Auto_BillEmail"
    t.index ["BillFirstName"], name: "IX_Auto_BillFirstName"
    t.index ["BillLastName"], name: "IX_Auto_BillLastName"
    t.index ["BillPostalCode"], name: "IX_Auto_BillPostalCode"
    t.index ["BillStateProvCode"], name: "IX_Auto_BillStateProvCode"
    t.index ["RollupNoteCount"], name: "IX_Auto_RollupNoteCount"
    t.index ["RollupOrderCount"], name: "IX_Auto_RollupOrderCount"
    t.index ["RollupOrderTotal"], name: "IX_Auto_RollupOrderTotal"
    t.index ["ShipCompany"], name: "IX_Auto_ShipCompany"
    t.index ["ShipCountryCode"], name: "IX_Auto_ShipCountryCode"
    t.index ["ShipEmail"], name: "IX_Auto_ShipEmail"
    t.index ["ShipLastName"], name: "IX_Auto_ShipLastName"
    t.index ["ShipPostalCode"], name: "IX_Auto_ShipPostalCode"
    t.index ["ShipStateProvCode"], name: "IX_Auto_ShipStateProvCode"
  end

  create_table "DimensionsProfile", primary_key: "DimensionsProfileID", id: :bigint, force: :cascade do |t|
    t.string "Name",   limit: 50, null: false
    t.float  "Length",            null: false
    t.float  "Width",             null: false
    t.float  "Height",            null: false
    t.float  "Weight",            null: false
    t.index ["Name"], name: "IX_DimensionsProfile_Name", unique: true
  end

  create_table "Dirty", id: false, force: :cascade do |t|
    t.ss_timestamp "RowVersion", null: false
    t.bigint       "Count"
  end

  create_table "Download", primary_key: "DownloadID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                       null: false
    t.bigint       "StoreID",                          null: false
    t.bigint       "ComputerID",                       null: false
    t.bigint       "UserID",                           null: false
    t.integer      "InitiatedBy",                      null: false
    t.datetime     "Started",                          null: false
    t.datetime     "Ended"
    t.integer      "Duration"
    t.integer      "QuantityTotal"
    t.integer      "QuantityNew"
    t.integer      "Result",                           null: false
    t.text         "ErrorMessage",  limit: 2147483647
    t.index ["StoreID", "Ended"], name: "IX_DownloadLog_StoreID_Ended"
  end

  create_table "DownloadDetail", primary_key: "DownloadedDetailID", id: :bigint, force: :cascade do |t|
    t.bigint  "DownloadID",                  null: false
    t.bigint  "OrderID",                     null: false
    t.boolean "InitialDownload",             null: false
    t.bigint  "OrderNumber"
    t.bigint  "ExtraBigIntData1"
    t.bigint  "ExtraBigIntData2"
    t.bigint  "ExtraBigIntData3"
    t.string  "ExtraStringData1", limit: 50
    t.index ["DownloadID"], name: "IX_DownloadDetail_DownloadID"
    t.index ["ExtraBigIntData1", "ExtraBigIntData2", "ExtraBigIntData3"], name: "IX_DownloadDetail_BigIntIndex"
    t.index ["ExtraStringData1"], name: "IX_DownloadDetail_String"
    t.index ["OrderID"], name: "IX_DownloadDetail_OrderID"
    t.index ["OrderNumber"], name: "IX_DownloadDetail_OrderNumber"
  end

  create_table "EbayCombinedOrderRelation", primary_key: "EbayCombinedOrderRelationID", id: :bigint, force: :cascade do |t|
    t.bigint "OrderID",     null: false
    t.bigint "EbayOrderID", null: false
    t.bigint "StoreID",     null: false
    t.index ["EbayOrderID"], name: "IX_EbayCombinedOrderRelation", unique: true
  end

  create_table "EbayOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.bigint  "EbayOrderID",                                            null: false
    t.string  "EbayBuyerID",                    limit: 50,              null: false
    t.boolean "CombinedLocally",                                        null: false
    t.integer "SelectedShippingMethod",                     default: 0, null: false
    t.integer "SellingManagerRecord"
    t.boolean "GspEligible",                                            null: false
    t.string  "GspFirstName",                   limit: 128,             null: false
    t.string  "GspLastName",                    limit: 128,             null: false
    t.string  "GspStreet1",                     limit: 512,             null: false
    t.string  "GspStreet2",                     limit: 512,             null: false
    t.string  "GspCity",                        limit: 128,             null: false
    t.string  "GspStateProvince",               limit: 128,             null: false
    t.string  "GspPostalCode",                  limit: 9,               null: false
    t.string  "GspCountryCode",                 limit: 2,               null: false
    t.string  "GspReferenceID",                 limit: 128,             null: false
    t.integer "RollupEbayItemCount",                                    null: false
    t.integer "RollupEffectiveCheckoutStatus"
    t.integer "RollupEffectivePaymentMethod"
    t.integer "RollupFeedbackLeftType"
    t.varchar "RollupFeedbackLeftComments",     limit: 80
    t.integer "RollupFeedbackReceivedType"
    t.varchar "RollupFeedbackReceivedComments", limit: 80
    t.integer "RollupPayPalAddressStatus"
    t.index ["EbayBuyerID"], name: "IX_EbayOrder_EbayBuyerID"
  end

  create_table "EbayOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.bigint  "OrderID",                             null: false
    t.bigint  "EbayItemID",                          null: false
    t.bigint  "EbayTransactionID",                   null: false
    t.integer "SellingManagerRecord",                null: false
    t.integer "EffectiveCheckoutStatus",             null: false
    t.integer "EffectivePaymentMethod",              null: false
    t.integer "PaymentStatus",                       null: false
    t.integer "PaymentMethod",                       null: false
    t.integer "CompleteStatus",                      null: false
    t.integer "FeedbackLeftType",                    null: false
    t.string  "FeedbackLeftComments",     limit: 80, null: false
    t.integer "FeedbackReceivedType",                null: false
    t.string  "FeedbackReceivedComments", limit: 80, null: false
    t.boolean "MyEbayPaid",                          null: false
    t.boolean "MyEbayShipped",                       null: false
    t.varchar "PayPalTransactionID",      limit: 50, null: false
    t.integer "PayPalAddressStatus",                 null: false
    t.index ["OrderID"], name: "IX_EbayOrderItem_OrderID"
  end

  create_table "EbayStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string     "eBayUserID",                   limit: 50,         null: false
    t.text_basic "eBayToken",                    limit: 2147483647, null: false
    t.datetime   "eBayTokenExpire",                                 null: false
    t.varchar    "AcceptedPaymentList",          limit: 30,         null: false
    t.boolean    "DownloadItemDetails",                             null: false
    t.boolean    "DownloadOlderOrders",                             null: false
    t.boolean    "DownloadPayPalDetails",                           null: false
    t.integer    "PayPalApiCredentialType",      limit: 2,          null: false
    t.string     "PayPalApiUserName",            limit: 255,        null: false
    t.string     "PayPalApiPassword",            limit: 80,         null: false
    t.string     "PayPalApiSignature",           limit: 80,         null: false
    t.varbinary  "PayPalApiCertificate",         limit: 2048
    t.string     "DomesticShippingService",      limit: 50,         null: false
    t.string     "InternationalShippingService", limit: 50,         null: false
    t.datetime   "FeedbackUpdatedThrough"
  end

  create_table "EmailAccount", primary_key: "EmailAccountID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                     null: false
    t.string       "AccountName",                        limit: 50,  null: false
    t.string       "DisplayName",                        limit: 50,  null: false
    t.string       "EmailAddress",                       limit: 100, null: false
    t.string       "IncomingServer",                     limit: 100, null: false
    t.integer      "IncomingServerType",                             null: false
    t.integer      "IncomingPort",                                   null: false
    t.integer      "IncomingSecurityType",                           null: false
    t.string       "IncomingUsername",                   limit: 50,  null: false
    t.string       "IncomingPassword",                   limit: 150, null: false
    t.string       "OutgoingServer",                     limit: 100, null: false
    t.integer      "OutgoingPort",                                   null: false
    t.integer      "OutgoingSecurityType",                           null: false
    t.integer      "OutgoingCredentialSource",                       null: false
    t.string       "OutgoingUsername",                   limit: 50,  null: false
    t.string       "OutgoingPassword",                   limit: 150, null: false
    t.boolean      "AutoSend",                                       null: false
    t.integer      "AutoSendMinutes",                                null: false
    t.datetime     "AutoSendLastTime",                               null: false
    t.boolean      "LimitMessagesPerConnection",                     null: false
    t.integer      "LimitMessagesPerConnectionQuantity",             null: false
    t.boolean      "LimitMessagesPerHour",                           null: false
    t.integer      "LimitMessagesPerHourQuantity",                   null: false
    t.boolean      "LimitMessageInterval",                           null: false
    t.integer      "LimitMessageIntervalSeconds",                    null: false
    t.bigint       "InternalOwnerID"
  end

  create_table "EmailOutbound", primary_key: "EmailOutboundID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                              null: false
    t.bigint       "ContextID"
    t.integer      "ContextType"
    t.bigint       "TemplateID"
    t.bigint       "AccountID",                               null: false
    t.integer      "Visibility",                              null: false
    t.string       "FromAddress",          limit: 200,        null: false
    t.text         "ToList",               limit: 2147483647, null: false
    t.text         "CcList",               limit: 2147483647, null: false
    t.text         "BccList",              limit: 2147483647, null: false
    t.string       "Subject",              limit: 300,        null: false
    t.bigint       "HtmlPartResourceID"
    t.bigint       "PlainPartResourceID",                     null: false
    t.varchar      "Encoding",             limit: 20
    t.datetime     "ComposedDate",                            null: false
    t.datetime     "SentDate",                                null: false
    t.datetime     "DontSendBefore"
    t.integer      "SendStatus",                              null: false
    t.integer      "SendAttemptCount",                        null: false
    t.string       "SendAttemptLastError", limit: 300,        null: false
    t.index ["SendStatus", "AccountID", "DontSendBefore", "SentDate", "ComposedDate"], name: "IX_EmailOutbound"
  end

  create_table "EmailOutboundRelation", primary_key: "EmailOutboundRelationID", id: :bigint, force: :cascade do |t|
    t.bigint  "EmailOutboundID", null: false
    t.bigint  "ObjectID",        null: false
    t.integer "RelationType",    null: false
    t.index ["EmailOutboundID", "RelationType"], name: "IX_EmailOutbound_EmailOutboundIDRelationTypeObjectID"
    t.index ["ObjectID", "RelationType"], name: "IX_EmailOutbound_ObjectIDRelationTypeEmailOutboundID"
    t.index ["RelationType", "ObjectID"], name: "IX_EmailOutbound_RelationTypeObject"
  end

  create_table "EndiciaAccount", primary_key: "EndiciaAccountID", id: :bigint, force: :cascade do |t|
    t.integer "EndiciaReseller",                   null: false
    t.string  "AccountNumber",         limit: 50
    t.string  "SignupConfirmation",    limit: 30,  null: false
    t.string  "WebPassword",           limit: 250, null: false
    t.string  "ApiInitialPassword",    limit: 250, null: false
    t.string  "ApiUserPassword",       limit: 250, null: false
    t.integer "AccountType",                       null: false
    t.boolean "TestAccount",                       null: false
    t.boolean "CreatedByShipWorks",                null: false
    t.string  "Description",           limit: 50,  null: false
    t.string  "FirstName",             limit: 30,  null: false
    t.string  "LastName",              limit: 30,  null: false
    t.string  "Company",               limit: 30,  null: false
    t.string  "Street1",               limit: 60,  null: false
    t.string  "Street2",               limit: 60,  null: false
    t.string  "Street3",               limit: 60,  null: false
    t.string  "City",                  limit: 50,  null: false
    t.string  "StateProvCode",         limit: 50,  null: false
    t.string  "PostalCode",            limit: 20,  null: false
    t.string  "CountryCode",           limit: 50,  null: false
    t.string  "Phone",                 limit: 25,  null: false
    t.string  "Fax",                   limit: 35,  null: false
    t.string  "Email",                 limit: 100, null: false
    t.string  "MailingPostalCode",     limit: 20,  null: false
    t.integer "ScanFormAddressSource",             null: false
  end

  create_table "EndiciaProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "EndiciaAccountID"
    t.boolean "StealthPostage"
    t.string  "ReferenceID",      limit: 300
    t.boolean "ScanBasedReturn"
  end

  create_table "EndiciaScanForm", primary_key: "EndiciaScanFormID", id: :bigint, force: :cascade do |t|
    t.bigint   "EndiciaAccountID",                 null: false
    t.string   "EndiciaAccountNumber", limit: 50,  null: false
    t.varchar  "SubmissionID",         limit: 100, null: false
    t.datetime "CreatedDate",                      null: false
    t.bigint   "ScanFormBatchID",                  null: false
    t.string   "Description",          limit: 100, null: false
  end

  create_table "EndiciaShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.bigint  "EndiciaAccountID",                     null: false
    t.bigint  "OriginalEndiciaAccountID"
    t.boolean "StealthPostage",                       null: false
    t.string  "ReferenceID",              limit: 300, null: false
    t.integer "TransactionID"
    t.integer "RefundFormID"
    t.bigint  "ScanFormBatchID"
    t.boolean "ScanBasedReturn",                      null: false
    t.integer "RequestedLabelFormat",                 null: false
  end

  create_table "EtsyOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.boolean "WasPaid",    null: false
    t.boolean "WasShipped", null: false
  end

  create_table "EtsyStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.bigint "EtsyShopID",                   null: false
    t.string "EtsyLogin",        limit: 255, null: false
    t.string "EtsyStoreName",    limit: 255, null: false
    t.string "OAuthToken",       limit: 50,  null: false
    t.string "OAuthTokenSecret", limit: 50,  null: false
  end

  create_table "ExcludedPackageType", primary_key: ["ShipmentType", "PackageType"], force: :cascade do |t|
    t.integer "ShipmentType", null: false
    t.integer "PackageType",  null: false
  end

  create_table "ExcludedServiceType", primary_key: ["ShipmentType", "ServiceType"], force: :cascade do |t|
    t.integer "ShipmentType", null: false
    t.integer "ServiceType",  null: false
  end

  create_table "FedExAccount", primary_key: "FedExAccountID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                   null: false
    t.string       "Description",      limit: 50,  null: false
    t.string       "AccountNumber",    limit: 12,  null: false
    t.varchar      "SignatureRelease", limit: 10,  null: false
    t.string       "MeterNumber",      limit: 50,  null: false
    t.string       "SmartPostHubList",             null: false
    t.string       "FirstName",        limit: 30,  null: false
    t.string       "MiddleName",       limit: 30,  null: false
    t.string       "LastName",         limit: 30,  null: false
    t.string       "Company",          limit: 35,  null: false
    t.string       "Street1",          limit: 60,  null: false
    t.string       "Street2",          limit: 60,  null: false
    t.string       "City",             limit: 50,  null: false
    t.string       "StateProvCode",    limit: 50,  null: false
    t.string       "PostalCode",       limit: 20,  null: false
    t.string       "CountryCode",      limit: 50,  null: false
    t.string       "Phone",            limit: 25,  null: false
    t.string       "Email",            limit: 100, null: false
    t.string       "Website",          limit: 50,  null: false
  end

  create_table "FedExEndOfDayClose", primary_key: "FedExEndOfDayCloseID", id: :bigint, force: :cascade do |t|
    t.bigint   "FedExAccountID",            null: false
    t.string   "AccountNumber",  limit: 50, null: false
    t.datetime "CloseDate",                 null: false
    t.boolean  "IsSmartPost",               null: false
    t.index ["CloseDate"], name: "IX_FedExEndOfDayClose_CloseDate"
  end

  create_table "FedExPackage", primary_key: "FedExPackageID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShipmentID",                                                                                null: false
    t.float   "Weight",                                                                                    null: false
    t.bigint  "DimsProfileID",                                                                             null: false
    t.float   "DimsLength",                                                                                null: false
    t.float   "DimsWidth",                                                                                 null: false
    t.float   "DimsHeight",                                                                                null: false
    t.float   "DimsWeight",                                                                                null: false
    t.boolean "DimsAddWeight",                                                                             null: false
    t.integer "SkidPieces",                                                                                null: false
    t.boolean "Insurance",                                                                 default: false, null: false
    t.money   "InsuranceValue",                                   precision: 19, scale: 4,                 null: false
    t.boolean "InsurancePennyOne",                                                                         null: false
    t.money   "DeclaredValue",                                    precision: 19, scale: 4,                 null: false
    t.varchar "TrackingNumber",                      limit: 50,                                            null: false
    t.boolean "PriorityAlert",                                                                             null: false
    t.integer "PriorityAlertEnhancementType",                                                              null: false
    t.string  "PriorityAlertDetailContent",          limit: 1024,                                          null: false
    t.float   "DryIceWeight",                                                                              null: false
    t.boolean "ContainsAlcohol",                                                                           null: false
    t.boolean "DangerousGoodsEnabled",                                                                     null: false
    t.integer "DangerousGoodsType",                                                                        null: false
    t.integer "DangerousGoodsAccessibilityType",                                                           null: false
    t.boolean "DangerousGoodsCargoAircraftOnly",                                                           null: false
    t.string  "DangerousGoodsEmergencyContactPhone", limit: 16,                                            null: false
    t.string  "DangerousGoodsOfferor",               limit: 128,                                           null: false
    t.integer "DangerousGoodsPackagingCount",                                                              null: false
    t.string  "HazardousMaterialNumber",             limit: 16,                                            null: false
    t.string  "HazardousMaterialClass",              limit: 8,                                             null: false
    t.string  "HazardousMaterialProperName",         limit: 64,                                            null: false
    t.integer "HazardousMaterialPackingGroup",                                                             null: false
    t.float   "HazardousMaterialQuantityValue",                                                            null: false
    t.integer "HazardousMaterialQuanityUnits",                                                             null: false
    t.string  "HazardousMaterialTechnicalName",      limit: 64,                                            null: false
    t.string  "SignatoryContactName",                limit: 100,                                           null: false
    t.string  "SignatoryTitle",                      limit: 100,                                           null: false
    t.string  "SignatoryPlace",                      limit: 100,                                           null: false
    t.integer "AlcoholRecipientType",                                                                      null: false
    t.string  "ContainerType",                       limit: 100,                                           null: false
    t.integer "NumberOfContainers",                                                                        null: false
    t.boolean "PackingDetailsCargoAircraftOnly",                                                           null: false
    t.string  "PackingDetailsPackingInstructions",   limit: 50,                                            null: false
    t.index ["ShipmentID"], name: "IX_FedExPackage_ShipmentID"
  end

  create_table "FedExProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "FedExAccountID"
    t.integer "Service"
    t.integer "Signature"
    t.integer "PackagingType"
    t.boolean "NonStandardContainer"
    t.string  "ReferenceCustomer",              limit: 300
    t.string  "ReferenceInvoice",               limit: 300
    t.string  "ReferencePO",                    limit: 300
    t.string  "ReferenceShipmentIntegrity",     limit: 300
    t.integer "PayorTransportType"
    t.varchar "PayorTransportAccount",          limit: 12
    t.integer "PayorDutiesType"
    t.varchar "PayorDutiesAccount",             limit: 12
    t.boolean "SaturdayDelivery"
    t.integer "EmailNotifySender"
    t.integer "EmailNotifyRecipient"
    t.integer "EmailNotifyOther"
    t.string  "EmailNotifyOtherAddress",        limit: 100
    t.varchar "EmailNotifyMessage",             limit: 120
    t.integer "ResidentialDetermination"
    t.integer "SmartPostIndicia"
    t.integer "SmartPostEndorsement"
    t.boolean "SmartPostConfirmation"
    t.string  "SmartPostCustomerManifest",      limit: 50
    t.varchar "SmartPostHubID",                 limit: 10
    t.integer "EmailNotifyBroker"
    t.integer "DropoffType"
    t.integer "OriginResidentialDetermination"
    t.nchar   "PayorTransportName",             limit: 60
    t.integer "ReturnType"
    t.string  "RmaNumber",                      limit: 30
    t.string  "RmaReason",                      limit: 60
    t.boolean "ReturnSaturdayPickup"
    t.boolean "ReturnsClearance"
    t.string  "ReferenceFIMS",                  limit: 300
    t.boolean "ThirdPartyConsignee"
  end

  create_table "FedExProfilePackage", primary_key: "FedExProfilePackageID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShippingProfileID",                                null: false
    t.float   "Weight"
    t.bigint  "DimsProfileID"
    t.float   "DimsLength"
    t.float   "DimsWidth"
    t.float   "DimsHeight"
    t.float   "DimsWeight"
    t.boolean "DimsAddWeight"
    t.boolean "PriorityAlert"
    t.integer "PriorityAlertEnhancementType"
    t.string  "PriorityAlertDetailContent",          limit: 1024
    t.float   "DryIceWeight"
    t.boolean "ContainsAlcohol"
    t.boolean "DangerousGoodsEnabled"
    t.integer "DangerousGoodsType"
    t.integer "DangerousGoodsAccessibilityType"
    t.boolean "DangerousGoodsCargoAircraftOnly"
    t.string  "DangerousGoodsEmergencyContactPhone", limit: 16
    t.string  "DangerousGoodsOfferor",               limit: 128
    t.integer "DangerousGoodsPackagingCount"
    t.string  "HazardousMaterialNumber",             limit: 16
    t.string  "HazardousMaterialClass",              limit: 8
    t.string  "HazardousMaterialProperName",         limit: 64
    t.integer "HazardousMaterialPackingGroup"
    t.float   "HazardousMaterialQuantityValue"
    t.integer "HazardousMaterialQuanityUnits"
    t.string  "SignatoryContactName",                limit: 100
    t.string  "SignatoryTitle",                      limit: 100
    t.string  "SignatoryPlace",                      limit: 100
    t.string  "ContainerType",                       limit: 100
    t.integer "NumberOfContainers"
    t.boolean "PackingDetailsCargoAircraftOnly"
    t.string  "PackingDetailsPackingInstructions",   limit: 50
  end

  create_table "FedExShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.bigint   "FedExAccountID",                                                                                     null: false
    t.varchar  "MasterFormID",                                  limit: 4,                                            null: false
    t.integer  "Service",                                                                                            null: false
    t.integer  "Signature",                                                                                          null: false
    t.integer  "PackagingType",                                                                                      null: false
    t.boolean  "NonStandardContainer",                                                                               null: false
    t.string   "ReferenceCustomer",                             limit: 300,                                          null: false
    t.string   "ReferenceInvoice",                              limit: 300,                                          null: false
    t.string   "ReferencePO",                                   limit: 300,                                          null: false
    t.string   "ReferenceShipmentIntegrity",                    limit: 300,                                          null: false
    t.integer  "PayorTransportType",                                                                                 null: false
    t.string   "PayorTransportName",                            limit: 60,                                           null: false
    t.varchar  "PayorTransportAccount",                         limit: 12,                                           null: false
    t.integer  "PayorDutiesType",                                                                                    null: false
    t.varchar  "PayorDutiesAccount",                            limit: 12,                                           null: false
    t.string   "PayorDutiesName",                               limit: 60,                                           null: false
    t.string   "PayorDutiesCountryCode",                        limit: 50,                                           null: false
    t.boolean  "SaturdayDelivery",                                                                                   null: false
    t.integer  "HomeDeliveryType",                                                                                   null: false
    t.varchar  "HomeDeliveryInstructions",                      limit: 74,                                           null: false
    t.datetime "HomeDeliveryDate",                                                                                   null: false
    t.varchar  "HomeDeliveryPhone",                             limit: 24,                                           null: false
    t.boolean  "FreightInsidePickup",                                                                                null: false
    t.boolean  "FreightInsideDelivery",                                                                              null: false
    t.varchar  "FreightBookingNumber",                          limit: 12,                                           null: false
    t.integer  "FreightLoadAndCount",                                                                                null: false
    t.integer  "EmailNotifyBroker",                                                                                  null: false
    t.integer  "EmailNotifySender",                                                                                  null: false
    t.integer  "EmailNotifyRecipient",                                                                               null: false
    t.integer  "EmailNotifyOther",                                                                                   null: false
    t.string   "EmailNotifyOtherAddress",                       limit: 100,                                          null: false
    t.varchar  "EmailNotifyMessage",                            limit: 120,                                          null: false
    t.boolean  "CodEnabled",                                                                                         null: false
    t.money    "CodAmount",                                                 precision: 19, scale: 4,                 null: false
    t.integer  "CodPaymentType",                                                                                     null: false
    t.boolean  "CodAddFreight",                                                                                      null: false
    t.bigint   "CodOriginID",                                                                                        null: false
    t.string   "CodFirstName",                                  limit: 30,                                           null: false
    t.string   "CodLastName",                                   limit: 30,                                           null: false
    t.string   "CodCompany",                                    limit: 35,                                           null: false
    t.string   "CodStreet1",                                    limit: 60,                                           null: false
    t.string   "CodStreet2",                                    limit: 60,                                           null: false
    t.string   "CodStreet3",                                    limit: 60,                                           null: false
    t.string   "CodCity",                                       limit: 50,                                           null: false
    t.string   "CodStateProvCode",                              limit: 50,                                           null: false
    t.string   "CodPostalCode",                                 limit: 20,                                           null: false
    t.string   "CodCountryCode",                                limit: 50,                                           null: false
    t.string   "CodPhone",                                      limit: 25,                                           null: false
    t.varchar  "CodTrackingNumber",                             limit: 50,                                           null: false
    t.varchar  "CodTrackingFormID",                             limit: 4,                                            null: false
    t.string   "CodTIN",                                        limit: 24,                                           null: false
    t.integer  "CodChargeBasis",                                                                                     null: false
    t.string   "CodAccountNumber",                              limit: 25,                                           null: false
    t.boolean  "BrokerEnabled",                                                                                      null: false
    t.string   "BrokerAccount",                                 limit: 12,                                           null: false
    t.string   "BrokerFirstName",                               limit: 30,                                           null: false
    t.string   "BrokerLastName",                                limit: 30,                                           null: false
    t.string   "BrokerCompany",                                 limit: 35,                                           null: false
    t.string   "BrokerStreet1",                                 limit: 60,                                           null: false
    t.string   "BrokerStreet2",                                 limit: 60,                                           null: false
    t.string   "BrokerStreet3",                                 limit: 60,                                           null: false
    t.string   "BrokerCity",                                    limit: 50,                                           null: false
    t.string   "BrokerStateProvCode",                           limit: 50,                                           null: false
    t.string   "BrokerPostalCode",                              limit: 20,                                           null: false
    t.string   "BrokerCountryCode",                             limit: 50,                                           null: false
    t.string   "BrokerPhone",                                   limit: 25,                                           null: false
    t.string   "BrokerPhoneExtension",                          limit: 8,                                            null: false
    t.string   "BrokerEmail",                                   limit: 100,                                          null: false
    t.integer  "CustomsAdmissibilityPackaging",                                                                      null: false
    t.varchar  "CustomsRecipientTIN",                           limit: 24,                                           null: false
    t.boolean  "CustomsDocumentsOnly",                                                                               null: false
    t.string   "CustomsDocumentsDescription",                   limit: 150,                                          null: false
    t.integer  "CustomsExportFilingOption",                                                                          null: false
    t.string   "CustomsAESEEI",                                 limit: 100,                                          null: false
    t.integer  "CustomsRecipientIdentificationType",                                                                 null: false
    t.string   "CustomsRecipientIdentificationValue",           limit: 50,                                           null: false
    t.integer  "CustomsOptionsType",                                                                                 null: false
    t.string   "CustomsOptionsDesription",                      limit: 32,                                           null: false
    t.boolean  "CommercialInvoice",                                                                                  null: false
    t.boolean  "CommercialInvoiceFileElectronically",                                                                null: false
    t.integer  "CommercialInvoiceTermsOfSale",                                                                       null: false
    t.integer  "CommercialInvoicePurpose",                                                                           null: false
    t.string   "CommercialInvoiceComments",                     limit: 200,                                          null: false
    t.money    "CommercialInvoiceFreight",                                  precision: 19, scale: 4,                 null: false
    t.money    "CommercialInvoiceInsurance",                                precision: 19, scale: 4,                 null: false
    t.money    "CommercialInvoiceOther",                                    precision: 19, scale: 4,                 null: false
    t.string   "CommercialInvoiceReference",                    limit: 300,                                          null: false
    t.boolean  "ImporterOfRecord",                                                                                   null: false
    t.string   "ImporterAccount",                               limit: 12,                                           null: false
    t.string   "ImporterTIN",                                   limit: 24,                                           null: false
    t.string   "ImporterFirstName",                             limit: 30,                                           null: false
    t.string   "ImporterLastName",                              limit: 30,                                           null: false
    t.string   "ImporterCompany",                               limit: 35,                                           null: false
    t.string   "ImporterStreet1",                               limit: 60,                                           null: false
    t.string   "ImporterStreet2",                               limit: 60,                                           null: false
    t.string   "ImporterStreet3",                               limit: 60,                                           null: false
    t.string   "ImporterCity",                                  limit: 50,                                           null: false
    t.string   "ImporterStateProvCode",                         limit: 50,                                           null: false
    t.string   "ImporterPostalCode",                            limit: 10,                                           null: false
    t.string   "ImporterCountryCode",                           limit: 50,                                           null: false
    t.string   "ImporterPhone",                                 limit: 25,                                           null: false
    t.integer  "SmartPostIndicia",                                                                                   null: false
    t.integer  "SmartPostEndorsement",                                                                               null: false
    t.boolean  "SmartPostConfirmation",                                                                              null: false
    t.string   "SmartPostCustomerManifest",                     limit: 300,                                          null: false
    t.varchar  "SmartPostHubID",                                limit: 10,                                           null: false
    t.string   "SmartPostUspsApplicationId",                    limit: 10,                                           null: false
    t.integer  "DropoffType",                                                                                        null: false
    t.integer  "OriginResidentialDetermination",                                                                     null: false
    t.boolean  "FedExHoldAtLocationEnabled",                                                                         null: false
    t.string   "HoldLocationId",                                limit: 50
    t.integer  "HoldLocationType"
    t.string   "HoldContactId",                                 limit: 50
    t.string   "HoldPersonName",                                limit: 100
    t.string   "HoldTitle",                                     limit: 50
    t.string   "HoldCompanyName",                               limit: 50
    t.string   "HoldPhoneNumber",                               limit: 30
    t.string   "HoldPhoneExtension",                            limit: 10
    t.string   "HoldPagerNumber",                               limit: 30
    t.string   "HoldFaxNumber",                                 limit: 30
    t.string   "HoldEmailAddress",                              limit: 100
    t.string   "HoldStreet1",                                   limit: 250
    t.string   "HoldStreet2",                                   limit: 250
    t.string   "HoldStreet3",                                   limit: 250
    t.string   "HoldCity",                                      limit: 100
    t.string   "HoldStateOrProvinceCode",                       limit: 50
    t.string   "HoldPostalCode",                                limit: 20
    t.string   "HoldUrbanizationCode",                          limit: 20
    t.string   "HoldCountryCode",                               limit: 20
    t.boolean  "HoldResidential"
    t.boolean  "CustomsNaftaEnabled",                                                                                null: false
    t.integer  "CustomsNaftaPreferenceType",                                                                         null: false
    t.integer  "CustomsNaftaDeterminationCode",                                                                      null: false
    t.string   "CustomsNaftaProducerId",                        limit: 20,                                           null: false
    t.integer  "CustomsNaftaNetCostMethod",                                                                          null: false
    t.integer  "ReturnType",                                                                                         null: false
    t.string   "RmaNumber",                                     limit: 30,                                           null: false
    t.string   "RmaReason",                                     limit: 60,                                           null: false
    t.boolean  "ReturnSaturdayPickup",                                                                               null: false
    t.string   "TrafficInArmsLicenseNumber",                    limit: 32,                                           null: false
    t.integer  "IntlExportDetailType",                                                                               null: false
    t.string   "IntlExportDetailForeignTradeZoneCode",          limit: 50,                                           null: false
    t.string   "IntlExportDetailEntryNumber",                   limit: 20,                                           null: false
    t.string   "IntlExportDetailLicenseOrPermitNumber",         limit: 50,                                           null: false
    t.datetime "IntlExportDetailLicenseOrPermitExpirationDate"
    t.integer  "WeightUnitType",                                                                                     null: false
    t.integer  "LinearUnitType",                                                                                     null: false
    t.integer  "RequestedLabelFormat",                                                                               null: false
    t.string   "FimsAirWaybill",                                limit: 50
    t.boolean  "ReturnsClearance",                                                                   default: false, null: false
    t.integer  "MaskedData"
    t.string   "ReferenceFIMS",                                 limit: 300,                                          null: false
    t.boolean  "ThirdPartyConsignee",                                                                                null: false
    t.integer  "Currency"
    t.boolean  "InternationalTrafficInArmsService"
    t.index ["PackagingType"], name: "IX_FedExShipment_PackagingType"
    t.index ["Service"], name: "IX_FedExShipment_Service"
  end

  create_table "Filter", primary_key: "FilterID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",              null: false
    t.string       "Name",         limit: 50, null: false
    t.integer      "FilterTarget",            null: false
    t.boolean      "IsFolder",                null: false
    t.string       "Definition"
    t.integer      "State",        limit: 1,  null: false
    t.index ["IsFolder"], name: "IX_Filter_IsFolder"
    t.index ["State"], name: "IX_Filter_State"
  end

  create_table "FilterLayout", primary_key: "FilterLayoutID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",   null: false
    t.bigint       "UserID"
    t.integer      "FilterTarget", null: false
    t.bigint       "FilterNodeID", null: false
    t.index ["UserID", "FilterTarget"], name: "IX_FilterLayout", unique: true
  end

  create_table "FilterNode", primary_key: "FilterNodeID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",          null: false
    t.bigint       "ParentFilterNodeID"
    t.bigint       "FilterSequenceID",    null: false
    t.bigint       "FilterNodeContentID", null: false
    t.datetime     "Created",             null: false
    t.integer      "Purpose",             null: false
    t.index ["FilterSequenceID", "FilterNodeContentID", "Purpose"], name: "IX_FilterNode_FilterSequenceID_FilterNodeContentID_Purpose"
    t.index ["ParentFilterNodeID"], name: "IX_FilterNode_ParentFilterNodeID"
  end

  create_table "FilterNodeColumnSettings", primary_key: "FilterNodeColumnSettingsID", id: :bigint, force: :cascade do |t|
    t.bigint  "UserID"
    t.bigint  "FilterNodeID",       null: false
    t.boolean "Inherit",            null: false
    t.bigint  "GridColumnLayoutID", null: false
    t.index ["UserID", "FilterNodeID"], name: "IX_FilterNodeColumnSettings", unique: true
  end

  create_table "FilterNodeContent", primary_key: "FilterNodeContentID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                            null: false
    t.bigint       "CountVersion",                          null: false
    t.integer      "Status",             limit: 2,          null: false
    t.text         "InitialCalculation", limit: 2147483647, null: false
    t.text         "UpdateCalculation",  limit: 2147483647, null: false
    t.varbinary    "ColumnMask",         limit: 100,        null: false
    t.integer      "JoinMask",                              null: false
    t.integer      "Cost",                                  null: false
    t.integer      "Count",                                 null: false
    t.index ["Status"], name: "IX_FilterNodeContent_Status"
  end

  create_table "FilterNodeContentDetail", primary_key: ["FilterNodeContentID", "ObjectID"], force: :cascade do |t|
    t.bigint "FilterNodeContentID", null: false
    t.bigint "ObjectID",            null: false
  end

  create_table "FilterNodeContentDirty", primary_key: ["ObjectID", "ComputerID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint       "FilterNodeContentDirtyID",             null: false
    t.ss_timestamp "RowVersion",                           null: false
    t.bigint       "ObjectID",                             null: false
    t.bigint       "ParentID"
    t.integer      "ObjectType",                           null: false
    t.bigint       "ComputerID",                           null: false
    t.varbinary    "ColumnsUpdated",           limit: 100, null: false
  end

  create_table "FilterNodeRootDirty", id: false, force: :cascade do |t|
    t.bigint  "FilterNodeContentID", null: false
    t.integer "Change",              null: false
  end

  create_table "FilterNodeUpdateCheckpoint", primary_key: "CheckpointID", id: :bigint, force: :cascade do |t|
    t.bigint  "MaxDirtyID", null: false
    t.integer "DirtyCount", null: false
    t.integer "State",      null: false
    t.integer "Duration",   null: false
  end

  create_table "FilterNodeUpdateCustomer", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "FilterNodeUpdateItem", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "FilterNodeUpdateOrder", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "FilterNodeUpdatePending", id: false, force: :cascade do |t|
    t.bigint    "FilterNodeContentID",             null: false
    t.integer   "FilterTarget",                    null: false
    t.varbinary "ColumnMask",          limit: 100, null: false
    t.integer   "JoinMask",                        null: false
    t.integer   "Position",                        null: false
  end

  create_table "FilterNodeUpdateShipment", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "FilterSequence", primary_key: "FilterSequenceID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",     null: false
    t.bigint       "ParentFilterID"
    t.bigint       "FilterID",       null: false
    t.integer      "Position",       null: false
    t.index ["FilterID"], name: "IX_FilterSequence_FilterID"
    t.index ["ParentFilterID"], name: "IX_FilterChild_ParentFilterID"
  end

  create_table "FtpAccount", primary_key: "FtpAccountID", id: :bigint, force: :cascade do |t|
    t.string  "Host",                          limit: 100,                 null: false
    t.string  "Username",                      limit: 50,                  null: false
    t.string  "Password",                      limit: 50,                  null: false
    t.integer "Port",                                                      null: false
    t.integer "SecurityType",                                              null: false
    t.boolean "Passive",                                                   null: false
    t.bigint  "InternalOwnerID"
    t.boolean "ReuseControlConnectionSession",             default: false, null: false
  end

  create_table "GenericFileStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.integer "FileFormat",                                               null: false
    t.integer "FileSource",                                               null: false
    t.string  "DiskFolder",               limit: 355,                     null: false
    t.bigint  "FtpAccountID"
    t.string  "FtpFolder",                limit: 355,                     null: false
    t.bigint  "EmailAccountID"
    t.string  "EmailFolder",              limit: 100,        default: "", null: false
    t.bigint  "EmailFolderValidityID",                                    null: false
    t.bigint  "EmailFolderLastMessageID",                                 null: false
    t.boolean "EmailOnlyUnread",                                          null: false
    t.string  "NamePatternMatch",         limit: 50
    t.string  "NamePatternSkip",          limit: 50
    t.integer "SuccessAction",                                            null: false
    t.string  "SuccessMoveFolder",        limit: 355,                     null: false
    t.integer "ErrorAction",                                              null: false
    t.string  "ErrorMoveFolder",          limit: 355,                     null: false
    t.string  "XmlXsltFileName",          limit: 355
    t.ntext   "XmlXsltContent",           limit: 2147483647
    t.ntext   "FlatImportMap",            limit: 2147483647,              null: false
  end

  create_table "GenericModuleStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "ModuleUsername",               limit: 50,  null: false
    t.string  "ModulePassword",               limit: 80,  null: false
    t.string  "ModuleUrl",                    limit: 350, null: false
    t.varchar "ModuleVersion",                limit: 20,  null: false
    t.string  "ModulePlatform",               limit: 50,  null: false
    t.string  "ModuleDeveloper",              limit: 50,  null: false
    t.string  "ModuleOnlineStoreCode",        limit: 50,  null: false
    t.string  "ModuleStatusCodes",                        null: false
    t.integer "ModuleDownloadPageSize",                   null: false
    t.integer "ModuleRequestTimeout",                     null: false
    t.integer "ModuleDownloadStrategy",                   null: false
    t.integer "ModuleOnlineStatusSupport",                null: false
    t.integer "ModuleOnlineStatusDataType",               null: false
    t.boolean "ModuleOnlineCustomerSupport",              null: false
    t.integer "ModuleOnlineCustomerDataType",             null: false
    t.boolean "ModuleOnlineShipmentDetails",              null: false
    t.boolean "ModuleHttpExpect100Continue",              null: false
    t.integer "ModuleResponseEncoding",                   null: false
    t.varchar "SchemaVersion",                limit: 20,  null: false
  end

  create_table "GridColumnFormat", primary_key: "GridColumnFormatID", id: :bigint, force: :cascade do |t|
    t.bigint "UserID",     null: false
    t.uuid   "ColumnGuid", null: false
    t.string "Settings",   null: false
    t.index ["UserID", "ColumnGuid"], name: "IX_GridColumnDisplay", unique: true
  end

  create_table "GridColumnLayout", primary_key: "GridColumnLayoutID", id: :bigint, force: :cascade do |t|
    t.integer "DefinitionSet",         null: false
    t.uuid    "DefaultSortColumnGuid", null: false
    t.integer "DefaultSortOrder",      null: false
    t.uuid    "LastSortColumnGuid",    null: false
    t.integer "LastSortOrder",         null: false
    t.string  "DetailViewSettings"
  end

  create_table "GridColumnPosition", primary_key: "GridColumnPositionID", id: :bigint, force: :cascade do |t|
    t.bigint  "GridColumnLayoutID", null: false
    t.uuid    "ColumnGuid",         null: false
    t.boolean "Visible",            null: false
    t.integer "Width",              null: false
    t.integer "Position",           null: false
    t.index ["GridColumnLayoutID", "ColumnGuid"], name: "IX_GridColumnPosition_GridColumnLayoutIdColumn", unique: true
  end

  create_table "GrouponOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.string "GrouponOrderID", limit: 50, null: false
    t.index ["GrouponOrderID"], name: "IX_Auto_GrouponOrderID"
  end

  create_table "GrouponOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.string "Permalink",             limit: 255, null: false
    t.string "ChannelSKUProvided",    limit: 255, null: false
    t.string "FulfillmentLineItemID", limit: 255, null: false
    t.string "BomSKU",                limit: 255, null: false
    t.string "GrouponLineItemID",     limit: 255, null: false
  end

  create_table "GrouponStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.varchar "SupplierID", limit: 255, null: false
    t.varchar "Token",      limit: 255, null: false
  end

  create_table "InfopiaOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.string "Marketplace",       limit: 50, null: false
    t.string "MarketplaceItemID", limit: 20, null: false
    t.string "BuyerID",           limit: 50, null: false
  end

  create_table "InfopiaStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.varchar "ApiToken", limit: 128, null: false
  end

  create_table "InsurancePolicy", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.string   "InsureShipStoreName", limit: 75,                           null: false
    t.boolean  "CreatedWithApi",                                           null: false
    t.string   "ItemName",            limit: 255
    t.string   "Description",         limit: 255
    t.integer  "ClaimType"
    t.money    "DamageValue",                     precision: 19, scale: 4
    t.datetime "SubmissionDate"
    t.bigint   "ClaimID"
    t.string   "EmailAddress",        limit: 100
  end

  create_table "LabelSheet", primary_key: "LabelSheetID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                    null: false
    t.string       "Name",              limit: 100, null: false
    t.float        "PaperSizeHeight",               null: false
    t.float        "PaperSizeWidth",                null: false
    t.float        "MarginTop",                     null: false
    t.float        "MarginLeft",                    null: false
    t.float        "LabelHeight",                   null: false
    t.float        "LabelWidth",                    null: false
    t.float        "VerticalSpacing",               null: false
    t.float        "HorizontalSpacing",             null: false
    t.integer      "Rows",                          null: false
    t.integer      "Columns",                       null: false
    t.index ["Name"], name: "IX_LabelSheet_Name", unique: true
  end

  create_table "LemonStandOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.string "LemonStandOrderID", limit: 20, null: false
    t.index ["LemonStandOrderID"], name: "IX_Auto_LemonStandOrderID"
  end

  create_table "LemonStandOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.string "UrlName",          limit: 100, null: false
    t.string "ShortDescription", limit: 255, null: false
    t.string "Category",         limit: 100, null: false
  end

  create_table "LemonStandStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.varchar "Token",       limit: 100, null: false
    t.varchar "StoreURL",    limit: 255, null: false
    t.string  "StatusCodes"
  end

  create_table "MagentoOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.bigint "MagentoOrderID", null: false
  end

  create_table "MagentoStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.boolean "MagentoTrackingEmails", null: false
    t.integer "MagentoVersion",        null: false
  end

  create_table "MarketplaceAdvisorOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.bigint "BuyerNumber",                  null: false
    t.bigint "SellerOrderNumber",            null: false
    t.string "InvoiceNumber",     limit: 50, null: false
    t.bigint "ParcelID",                     null: false
  end

  create_table "MarketplaceAdvisorStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "Username",      limit: 50, null: false
    t.string  "Password",      limit: 50, null: false
    t.integer "AccountType",              null: false
    t.integer "DownloadFlags",            null: false
  end

  create_table "MivaOrderItemAttribute", primary_key: "OrderItemAttributeID", id: :bigint, force: :cascade do |t|
    t.string  "MivaOptionCode",    limit: 300, null: false
    t.integer "MivaAttributeID",               null: false
    t.string  "MivaAttributeCode", limit: 300, null: false
  end

  create_table "MivaStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "EncryptionPassphrase",          limit: 50, null: false
    t.boolean "LiveManualOrderNumbers",                   null: false
    t.boolean "SebenzaCheckoutDataEnabled",               null: false
    t.integer "OnlineUpdateStrategy",                     null: false
    t.boolean "OnlineUpdateStatusChangeEmail",            null: false
  end

  create_table "NetworkSolutionsOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.bigint "NetworkSolutionsOrderID", null: false
  end

  create_table "NetworkSolutionsStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.varchar "UserToken",             limit: 50,  null: false
    t.varchar "DownloadOrderStatuses", limit: 50,  null: false
    t.string  "StatusCodes",                       null: false
    t.varchar "StoreUrl",              limit: 255, null: false
  end

  create_table "NeweggOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.bigint  "InvoiceNumber"
    t.money   "RefundAmount",  precision: 19, scale: 4
    t.boolean "IsAutoVoid"
  end

  create_table "NeweggOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.varchar "SellerPartNumber",          limit: 64
    t.varchar "NeweggItemNumber",          limit: 64
    t.varchar "ManufacturerPartNumber",    limit: 64
    t.integer "ShippingStatusID"
    t.varchar "ShippingStatusDescription", limit: 32
    t.integer "QuantityShipped"
  end

  create_table "NeweggStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.varchar "SellerID",                 limit: 10, null: false
    t.varchar "SecretKey",                limit: 50, null: false
    t.boolean "ExcludeFulfilledByNewegg",            null: false
    t.integer "Channel",                             null: false
  end

  create_table "Note", primary_key: "NoteID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                    null: false
    t.bigint       "ObjectID",                      null: false
    t.bigint       "UserID"
    t.datetime     "Edited",                        null: false
    t.text         "Text",       limit: 2147483647, null: false
    t.integer      "Source",                        null: false
    t.integer      "Visibility",                    null: false
    t.index ["ObjectID", "NoteID"], name: "IX_OrderNote_ObjectID", unique: true
  end

  create_table "ObjectLabel", primary_key: "ObjectID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",             null: false
    t.integer      "ObjectType",             null: false
    t.bigint       "ParentID"
    t.string       "Label",      limit: 100, null: false
    t.boolean      "IsDeleted",              null: false
    t.index ["ObjectType", "IsDeleted"], name: "IX_ObjectLabel_ObjectTypeIsDeleted"
  end

  create_table "ObjectReference", primary_key: "ObjectReferenceID", id: :bigint, force: :cascade do |t|
    t.bigint  "ConsumerID",                            null: false
    t.varchar "ReferenceKey", limit: 250, default: "", null: false
    t.bigint  "ObjectID",                              null: false
    t.string  "Reason",       limit: 250
    t.index ["ConsumerID", "ReferenceKey"], name: "IX_ObjectReference_ConsumerIDReferenceKey", unique: true
    t.index ["ObjectID"], name: "IX_ObjectReference_ObjectID"
  end

  create_table "OdbcStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "ImportConnectionString",  limit: 2048,       null: false
    t.text    "ImportMap",               limit: 2147483647, null: false
    t.integer "ImportStrategy",                             null: false
    t.integer "ImportColumnSourceType",                     null: false
    t.string  "ImportColumnSource",      limit: 2048,       null: false
    t.integer "ImportOrderItemStrategy",                    null: false
    t.integer "UploadStrategy",                             null: false
    t.text    "UploadMap",               limit: 2147483647, null: false
    t.integer "UploadColumnSourceType",                     null: false
    t.string  "UploadColumnSource",      limit: 2048,       null: false
    t.string  "UploadConnectionString",  limit: 2048,       null: false
  end

  create_table "OnTracAccount", primary_key: "OnTracAccountID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",               null: false
    t.integer      "AccountNumber",            null: false
    t.string       "Password",      limit: 50, null: false
    t.string       "Description",   limit: 50, null: false
    t.string       "FirstName",     limit: 30, null: false
    t.string       "MiddleName",    limit: 30, null: false
    t.string       "LastName",      limit: 30, null: false
    t.string       "Company",       limit: 30, null: false
    t.string       "Street1",       limit: 43, null: false
    t.string       "City",          limit: 25, null: false
    t.string       "StateProvCode", limit: 50, null: false
    t.string       "PostalCode",    limit: 10, null: false
    t.string       "CountryCode",   limit: 50, null: false
    t.string       "Email",         limit: 50, null: false
    t.string       "Phone",         limit: 15, null: false
  end

  create_table "OnTracProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "OnTracAccountID"
    t.integer "ResidentialDetermination"
    t.integer "Service"
    t.boolean "SaturdayDelivery"
    t.boolean "SignatureRequired"
    t.integer "PackagingType"
    t.float   "Weight"
    t.bigint  "DimsProfileID"
    t.float   "DimsLength"
    t.float   "DimsWidth"
    t.float   "DimsHeight"
    t.float   "DimsWeight"
    t.boolean "DimsAddWeight"
    t.string  "Reference1",               limit: 300
    t.string  "Reference2",               limit: 300
    t.string  "Instructions",             limit: 300
  end

  create_table "OnTracShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.bigint  "OnTracAccountID",                                           null: false
    t.integer "Service",                                                   null: false
    t.boolean "IsCod",                                                     null: false
    t.integer "CodType",                                                   null: false
    t.money   "CodAmount",                        precision: 19, scale: 4, null: false
    t.boolean "SaturdayDelivery",                                          null: false
    t.boolean "SignatureRequired",                                         null: false
    t.integer "PackagingType",                                             null: false
    t.string  "Instructions",         limit: 300,                          null: false
    t.bigint  "DimsProfileID",                                             null: false
    t.float   "DimsLength",                                                null: false
    t.float   "DimsWidth",                                                 null: false
    t.float   "DimsHeight",                                                null: false
    t.float   "DimsWeight",                                                null: false
    t.boolean "DimsAddWeight",                                             null: false
    t.string  "Reference1",           limit: 300,                          null: false
    t.string  "Reference2",           limit: 300,                          null: false
    t.money   "InsuranceValue",                   precision: 19, scale: 4, null: false
    t.boolean "InsurancePennyOne",                                         null: false
    t.money   "DeclaredValue",                    precision: 19, scale: 4, null: false
    t.integer "RequestedLabelFormat",                                      null: false
    t.index ["PackagingType"], name: "IX_OnTracShipment_PackagingType"
    t.index ["Service"], name: "IX_OnTracShipment_Service"
  end

  create_table "Order", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                                                null: false
    t.bigint       "StoreID",                                                                   null: false
    t.bigint       "CustomerID",                                                                null: false
    t.bigint       "OrderNumber",                                                               null: false
    t.string       "OrderNumberComplete",                  limit: 50,                           null: false
    t.datetime     "OrderDate",                                                                 null: false
    t.money        "OrderTotal",                                       precision: 19, scale: 4, null: false
    t.string       "LocalStatus",                          limit: 100,                          null: false
    t.boolean      "IsManual",                                                                  null: false
    t.datetime     "OnlineLastModified",                               precision: 7,            null: false
    t.string       "OnlineCustomerID"
    t.string       "OnlineStatus",                         limit: 100,                          null: false
    t.string       "OnlineStatusCode"
    t.string       "RequestedShipping",                    limit: 50,                           null: false
    t.string       "BillFirstName",                        limit: 30,                           null: false
    t.string       "BillMiddleName",                       limit: 30,                           null: false
    t.string       "BillLastName",                         limit: 30,                           null: false
    t.string       "BillCompany",                          limit: 60,                           null: false
    t.string       "BillStreet1",                          limit: 60,                           null: false
    t.string       "BillStreet2",                          limit: 60,                           null: false
    t.string       "BillStreet3",                          limit: 60,                           null: false
    t.string       "BillCity",                             limit: 50,                           null: false
    t.string       "BillStateProvCode",                    limit: 50,                           null: false
    t.string       "BillPostalCode",                       limit: 20,                           null: false
    t.string       "BillCountryCode",                      limit: 50,                           null: false
    t.string       "BillPhone",                            limit: 25,                           null: false
    t.string       "BillFax",                              limit: 35,                           null: false
    t.string       "BillEmail",                            limit: 100,                          null: false
    t.string       "BillWebsite",                          limit: 50,                           null: false
    t.integer      "BillAddressValidationSuggestionCount",                                      null: false
    t.integer      "BillAddressValidationStatus",                                               null: false
    t.string       "BillAddressValidationError",           limit: 300,                          null: false
    t.integer      "BillResidentialStatus",                                                     null: false
    t.integer      "BillPOBox",                                                                 null: false
    t.integer      "BillUSTerritory",                                                           null: false
    t.integer      "BillMilitaryAddress",                                                       null: false
    t.string       "ShipFirstName",                        limit: 30,                           null: false
    t.string       "ShipMiddleName",                       limit: 30,                           null: false
    t.string       "ShipLastName",                         limit: 30,                           null: false
    t.string       "ShipCompany",                          limit: 60,                           null: false
    t.string       "ShipStreet1",                          limit: 60,                           null: false
    t.string       "ShipStreet2",                          limit: 60,                           null: false
    t.string       "ShipStreet3",                          limit: 60,                           null: false
    t.string       "ShipCity",                             limit: 50,                           null: false
    t.string       "ShipStateProvCode",                    limit: 50,                           null: false
    t.string       "ShipPostalCode",                       limit: 20,                           null: false
    t.string       "ShipCountryCode",                      limit: 50,                           null: false
    t.string       "ShipPhone",                            limit: 25,                           null: false
    t.string       "ShipFax",                              limit: 35,                           null: false
    t.string       "ShipEmail",                            limit: 100,                          null: false
    t.string       "ShipWebsite",                          limit: 50,                           null: false
    t.integer      "ShipAddressValidationSuggestionCount",                                      null: false
    t.integer      "ShipAddressValidationStatus",                                               null: false
    t.string       "ShipAddressValidationError",           limit: 300,                          null: false
    t.integer      "ShipResidentialStatus",                                                     null: false
    t.integer      "ShipPOBox",                                                                 null: false
    t.integer      "ShipUSTerritory",                                                           null: false
    t.integer      "ShipMilitaryAddress",                                                       null: false
    t.integer      "RollupItemCount",                                                           null: false
    t.string       "RollupItemName",                       limit: 300
    t.string       "RollupItemCode",                       limit: 300
    t.string       "RollupItemSKU",                        limit: 100
    t.string       "RollupItemLocation",                   limit: 255
    t.float        "RollupItemQuantity"
    t.float        "RollupItemTotalWeight",                                                     null: false
    t.integer      "RollupNoteCount",                                                           null: false
    t.integer      "BillNameParseStatus",                                                       null: false
    t.string       "BillUnparsedName",                     limit: 100,                          null: false
    t.integer      "ShipNameParseStatus",                                                       null: false
    t.string       "ShipUnparsedName",                     limit: 100,                          null: false
    t.string       "ShipSenseHashKey",                     limit: 64,                           null: false, collation: SQL_Latin1_General_CP1_CS_AS
    t.integer      "ShipSenseRecognitionStatus",                                                null: false
    t.integer      "ShipAddressType",                                                           null: false
    t.index ["BillAddressValidationStatus"], name: "IX_Order_BillAddressValidationStatus"
    t.index ["BillCompany"], name: "IX_Auto_BillCompany"
    t.index ["BillCountryCode"], name: "IX_Auto_BillCountryCode"
    t.index ["BillEmail"], name: "IX_Auto_BillEmail"
    t.index ["BillFirstName"], name: "IX_Auto_BillFirstName"
    t.index ["BillLastName"], name: "IX_Auto_BillLastName"
    t.index ["BillMilitaryAddress"], name: "IX_Order_BillMilitaryAddress"
    t.index ["BillPOBox"], name: "IX_Order_BillPOBox"
    t.index ["BillPostalCode"], name: "IX_Auto_BillPostalCode"
    t.index ["BillResidentialStatus"], name: "IX_Order_BillResidentialStatus"
    t.index ["BillStateProvCode"], name: "IX_Auto_BillStateProvCode"
    t.index ["BillUSTerritory"], name: "IX_Order_BillUSTerritory"
    t.index ["CustomerID"], name: "IX_Auto_CustomerID"
    t.index ["LocalStatus"], name: "IX_Auto_LocalStatus"
    t.index ["OnlineCustomerID"], name: "IX_OnlineCustomerID"
    t.index ["OnlineLastModified", "StoreID", "IsManual"], name: "IX_OnlineLastModified_StoreID_IsManual"
    t.index ["OnlineStatus"], name: "IX_Auto_OnlineStatus"
    t.index ["OrderDate"], name: "IX_Auto_OrderDate"
    t.index ["OrderNumber"], name: "IX_Auto_OrderNumber"
    t.index ["OrderNumberComplete"], name: "IX_Auto_OrderNumberComplete"
    t.index ["OrderTotal"], name: "IX_Auto_OrderTotal"
    t.index ["RequestedShipping"], name: "IX_Auto_RequestedShipping"
    t.index ["RollupItemCode"], name: "IX_Auto_RollupItemCode"
    t.index ["RollupItemCount"], name: "IX_Auto_RollupItemCount"
    t.index ["RollupItemName", "OrderID"], name: "IX_Auto_RollupItemName"
    t.index ["RollupItemSKU"], name: "IX_Auto_RollupItemSKU"
    t.index ["RollupNoteCount"], name: "IX_Auto_RollupNoteCount"
    t.index ["ShipAddressValidationStatus"], name: "IX_Order_ShipAddressValidationStatus"
    t.index ["ShipCompany"], name: "IX_Auto_ShipCompany"
    t.index ["ShipCountryCode"], name: "IX_Auto_ShipCountryCode"
    t.index ["ShipEmail"], name: "IX_Auto_ShipEmail"
    t.index ["ShipFirstName"], name: "IX_Auto_ShipFirstName"
    t.index ["ShipLastName"], name: "IX_Auto_ShipLastName"
    t.index ["ShipMilitaryAddress"], name: "IX_Order_ShipMilitaryAddress"
    t.index ["ShipPOBox"], name: "IX_Order_ShipPOBox"
    t.index ["ShipPostalCode"], name: "IX_Auto_ShipPostalCode"
    t.index ["ShipResidentialStatus"], name: "IX_Order_ShipResidentialStatus"
    t.index ["ShipSenseHashKey"], name: "IX_Auto_ShipSenseHashKey"
    t.index ["ShipSenseRecognitionStatus"], name: "IX_Auto_ShipSenseRecognitionStatus"
    t.index ["ShipStateProvCode"], name: "IX_Auto_ShipStateProvCode"
    t.index ["ShipUSTerritory"], name: "IX_Order_ShipUSTerritory"
    t.index ["StoreID", "OnlineStatus"], name: "IX_Order_StoreIdOnlineStatus"
    t.index ["StoreID", "OrderDate", "LocalStatus"], name: "IX_Order_StoreIDOrderDateLocalStatus"
    t.index ["StoreID"], name: "IX_Auto_StoreID"
  end

  create_table "OrderCharge", primary_key: "OrderChargeID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                       null: false
    t.bigint       "OrderID",                                          null: false
    t.string       "Type",        limit: 50,                           null: false
    t.string       "Description", limit: 255,                          null: false
    t.money        "Amount",                  precision: 19, scale: 4, null: false
    t.index ["OrderID", "OrderChargeID"], name: "IX_OrderCharge_OrderID", unique: true
  end

  create_table "OrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                              null: false
    t.bigint       "OrderID",                                                 null: false
    t.string       "Name",        limit: 300,                                 null: false
    t.string       "Code",        limit: 300,                                 null: false
    t.string       "SKU",         limit: 100,                                 null: false
    t.string       "ISBN",        limit: 30,                                  null: false
    t.string       "UPC",         limit: 30,                                  null: false
    t.text         "Description", limit: 2147483647,                          null: false
    t.string       "Location",    limit: 255,                                 null: false
    t.text         "Image",       limit: 2147483647,                          null: false
    t.text         "Thumbnail",   limit: 2147483647,                          null: false
    t.money        "UnitPrice",                      precision: 19, scale: 4, null: false
    t.money        "UnitCost",                       precision: 19, scale: 4, null: false
    t.float        "Weight",                                                  null: false
    t.float        "Quantity",                                                null: false
    t.string       "LocalStatus", limit: 255,                                 null: false
    t.boolean      "IsManual",                                                null: false
    t.float        "TotalWeight",                                             null: false
    t.index ["OrderID", "OrderItemID"], name: "IX_OrderItem_OrderID", unique: true
  end

  create_table "OrderItemAttribute", primary_key: "OrderItemAttributeID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                              null: false
    t.bigint       "OrderItemID",                                             null: false
    t.string       "Name",        limit: 300,                                 null: false
    t.text         "Description", limit: 2147483647,                          null: false
    t.money        "UnitPrice",                      precision: 19, scale: 4, null: false
    t.boolean      "IsManual",                                                null: false
    t.index ["OrderItemID", "OrderItemAttributeID"], name: "IX_OrderItemAttribute_OrderItemID", unique: true
  end

  create_table "OrderMotionOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.integer "OrderMotionShipmentID",               null: false
    t.string  "OrderMotionPromotion",     limit: 50, null: false
    t.string  "OrderMotionInvoiceNumber", limit: 64, null: false
  end

  create_table "OrderMotionStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.bigint     "OrderMotionEmailAccountID",                    null: false
    t.text_basic "OrderMotionBizID",          limit: 2147483647, null: false
  end

  create_table "OrderPaymentDetail", primary_key: "OrderPaymentDetailID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",             null: false
    t.bigint       "OrderID",                null: false
    t.string       "Label",      limit: 100, null: false
    t.string       "Value",      limit: 100, null: false
    t.index ["OrderID", "OrderPaymentDetailID"], name: "IX_OrderPaymentDetail_OrderID", unique: true
  end

  create_table "OtherProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.string "Carrier", limit: 50
    t.string "Service", limit: 50
  end

  create_table "OtherShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.string "Carrier",        limit: 50,                          null: false
    t.string "Service",        limit: 50,                          null: false
    t.money  "InsuranceValue",            precision: 19, scale: 4, null: false
  end

  create_table "PayPalOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.string  "TransactionID", limit: 50,                          null: false
    t.integer "AddressStatus",                                     null: false
    t.money   "PayPalFee",                precision: 19, scale: 4, null: false
    t.integer "PaymentStatus",                                     null: false
    t.index ["PaymentStatus"], name: "IX_PayPalOrder_PaymentStatus"
  end

  create_table "PayPalStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.integer   "ApiCredentialType",        limit: 2,    null: false
    t.string    "ApiUserName",              limit: 255,  null: false
    t.string    "ApiPassword",              limit: 80,   null: false
    t.string    "ApiSignature",             limit: 80,   null: false
    t.varbinary "ApiCertificate",           limit: 2048
    t.datetime  "LastTransactionDate",                   null: false
    t.datetime  "LastValidTransactionDate",              null: false
  end

  create_table "Permission", primary_key: "PermissionID", id: :bigint, force: :cascade do |t|
    t.bigint  "UserID",         null: false
    t.integer "PermissionType", null: false
    t.bigint  "ObjectID"
    t.index ["UserID", "PermissionType", "ObjectID"], name: "IX_Permission", unique: true
  end

  create_table "PostalProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.integer "Service"
    t.integer "Confirmation"
    t.float   "Weight"
    t.integer "PackagingType"
    t.bigint  "DimsProfileID"
    t.float   "DimsLength"
    t.float   "DimsWidth"
    t.float   "DimsHeight"
    t.float   "DimsWeight"
    t.boolean "DimsAddWeight"
    t.boolean "NonRectangular"
    t.boolean "NonMachinable"
    t.integer "CustomsContentType"
    t.string  "CustomsContentDescription", limit: 50
    t.boolean "ExpressSignatureWaiver"
    t.integer "SortType"
    t.integer "EntryFacility"
    t.string  "Memo1",                     limit: 300
    t.string  "Memo2",                     limit: 300
    t.string  "Memo3",                     limit: 300
    t.boolean "NoPostage"
  end

  create_table "PostalShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.integer "Service",                                                                        null: false
    t.integer "Confirmation",                                                                   null: false
    t.integer "PackagingType",                                                                  null: false
    t.bigint  "DimsProfileID",                                                                  null: false
    t.float   "DimsLength",                                                                     null: false
    t.float   "DimsWidth",                                                                      null: false
    t.float   "DimsHeight",                                                                     null: false
    t.float   "DimsWeight",                                                                     null: false
    t.boolean "DimsAddWeight",                                                                  null: false
    t.boolean "NonRectangular",                                                                 null: false
    t.boolean "NonMachinable",                                                                  null: false
    t.integer "CustomsContentType",                                                             null: false
    t.string  "CustomsContentDescription", limit: 50,                                           null: false
    t.money   "InsuranceValue",                        precision: 19, scale: 4,                 null: false
    t.boolean "ExpressSignatureWaiver",                                                         null: false
    t.integer "SortType",                                                                       null: false
    t.integer "EntryFacility",                                                                  null: false
    t.string  "Memo1",                     limit: 300,                                          null: false
    t.string  "Memo2",                     limit: 300,                                          null: false
    t.string  "Memo3",                     limit: 300,                                          null: false
    t.boolean "NoPostage",                                                      default: false, null: false
    t.index ["Confirmation"], name: "IX_PostalShipment_Confirmation"
    t.index ["PackagingType"], name: "IX_PostalShipment_PackagingType"
    t.index ["Service"], name: "IX_PostalShipment_Service"
  end

  create_table "PrintResult", primary_key: "PrintResultID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                    null: false
    t.uuid         "JobIdentifier",                 null: false
    t.bigint       "RelatedObjectID",               null: false
    t.bigint       "ContextObjectID",               null: false
    t.bigint       "TemplateID"
    t.integer      "TemplateType"
    t.integer      "OutputFormat"
    t.bigint       "LabelSheetID"
    t.bigint       "ComputerID",                    null: false
    t.bigint       "ContentResourceID",             null: false
    t.datetime     "PrintDate",                     null: false
    t.string       "PrinterName",       limit: 350, null: false
    t.integer      "PaperSource",                   null: false
    t.string       "PaperSourceName",   limit: 100, null: false
    t.integer      "Copies",                        null: false
    t.boolean      "Collated",                      null: false
    t.float        "PageMarginLeft",                null: false
    t.float        "PageMarginRight",               null: false
    t.float        "PageMarginBottom",              null: false
    t.float        "PageMarginTop",                 null: false
    t.float        "PageWidth",                     null: false
    t.float        "PageHeight",                    null: false
    t.index ["PrintDate", "RelatedObjectID"], name: "IX_PrintResult_PrintDateRelatedObjectID"
    t.index ["RelatedObjectID"], name: "IX_PrintResult_RelatedObjectID"
  end

  create_table "ProStoresOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.varchar  "ConfirmationNumber", limit: 12, null: false
    t.datetime "AuthorizedDate"
    t.varchar  "AuthorizedBy",       limit: 50, null: false
  end

  create_table "ProStoresStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.varchar    "ShortName",           limit: 30,         null: false
    t.varchar    "Username",            limit: 50,         null: false
    t.integer    "LoginMethod",                            null: false
    t.varchar    "ApiEntryPoint",       limit: 300,        null: false
    t.text_basic "ApiToken",            limit: 2147483647, null: false
    t.varchar    "ApiStorefrontUrl",    limit: 300,        null: false
    t.varchar    "ApiTokenLogonUrl",    limit: 300,        null: false
    t.varchar    "ApiXteUrl",           limit: 300,        null: false
    t.varchar    "ApiRestSecureUrl",    limit: 300,        null: false
    t.varchar    "ApiRestNonSecureUrl", limit: 300,        null: false
    t.varchar    "ApiRestScriptSuffix", limit: 50,         null: false
    t.varchar    "LegacyAdminUrl",      limit: 300,        null: false
    t.varchar    "LegacyXtePath",       limit: 75,         null: false
    t.varchar    "LegacyPrefix",        limit: 30,         null: false
    t.varchar    "LegacyPassword",      limit: 150,        null: false
    t.boolean    "LegacyCanUpgrade",                       null: false
  end

  create_table "QuickFilterNodeContentDirty", primary_key: ["ObjectID", "ComputerID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint       "FilterNodeContentDirtyID",             null: false
    t.ss_timestamp "RowVersion",                           null: false
    t.bigint       "ObjectID",                             null: false
    t.bigint       "ParentID"
    t.integer      "ObjectType",                           null: false
    t.bigint       "ComputerID",                           null: false
    t.varbinary    "ColumnsUpdated",           limit: 100, null: false
  end

  create_table "QuickFilterNodeUpdateCheckpoint", primary_key: "CheckpointID", id: :bigint, force: :cascade do |t|
    t.bigint  "MaxDirtyID", null: false
    t.integer "DirtyCount", null: false
    t.integer "State",      null: false
    t.integer "Duration",   null: false
  end

  create_table "QuickFilterNodeUpdateCustomer", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "QuickFilterNodeUpdateItem", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "QuickFilterNodeUpdateOrder", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "QuickFilterNodeUpdatePending", id: false, force: :cascade do |t|
    t.bigint    "FilterNodeContentID",             null: false
    t.integer   "FilterTarget",                    null: false
    t.varbinary "ColumnMask",          limit: 100, null: false
    t.integer   "JoinMask",                        null: false
    t.integer   "Position",                        null: false
  end

  create_table "QuickFilterNodeUpdateShipment", primary_key: ["ObjectID", "ColumnsUpdated"], force: :cascade do |t|
    t.bigint    "ObjectID",                   null: false
    t.bigint    "ComputerID",                 null: false
    t.varbinary "ColumnsUpdated", limit: 100, null: false
  end

  create_table "Resource", primary_key: "ResourceID", id: :bigint, force: :cascade do |t|
    t.binary       "Data",       limit: 2147483647, null: false
    t.binary_basic "Checksum",   limit: 32,         null: false
    t.boolean      "Compressed",                    null: false
    t.string       "Filename",   limit: 30,         null: false
    t.index ["Checksum"], name: "IX_Resource_Checksum", unique: true
    t.index ["Filename"], name: "IX_Resource_Filename", unique: true
  end

  create_table "ScanFormBatch", primary_key: "ScanFormBatchID", id: :bigint, force: :cascade do |t|
    t.integer  "ShipmentType",  null: false
    t.datetime "CreatedDate",   null: false
    t.integer  "ShipmentCount", null: false
  end

  create_table "Scheduling_BLOB_TRIGGERS", primary_key: ["SCHED_NAME", "TRIGGER_NAME", "TRIGGER_GROUP"], force: :cascade do |t|
    t.string "SCHED_NAME",    limit: 100, null: false
    t.string "TRIGGER_NAME",  limit: 150, null: false
    t.string "TRIGGER_GROUP", limit: 150, null: false
    t.string "BLOB_DATA"
  end

  create_table "Scheduling_CALENDARS", primary_key: ["SCHED_NAME", "CALENDAR_NAME"], force: :cascade do |t|
    t.string "SCHED_NAME",    limit: 100, null: false
    t.string "CALENDAR_NAME", limit: 200, null: false
    t.string "CALENDAR",                  null: false
  end

  create_table "Scheduling_CRON_TRIGGERS", primary_key: ["SCHED_NAME", "TRIGGER_NAME", "TRIGGER_GROUP"], force: :cascade do |t|
    t.string "SCHED_NAME",      limit: 100, null: false
    t.string "TRIGGER_NAME",    limit: 150, null: false
    t.string "TRIGGER_GROUP",   limit: 150, null: false
    t.string "CRON_EXPRESSION", limit: 120, null: false
    t.string "TIME_ZONE_ID",    limit: 80
  end

  create_table "Scheduling_FIRED_TRIGGERS", primary_key: ["SCHED_NAME", "ENTRY_ID"], force: :cascade do |t|
    t.string  "SCHED_NAME",        limit: 100, null: false
    t.string  "ENTRY_ID",          limit: 95,  null: false
    t.string  "TRIGGER_NAME",      limit: 150, null: false
    t.string  "TRIGGER_GROUP",     limit: 150, null: false
    t.string  "INSTANCE_NAME",     limit: 200, null: false
    t.bigint  "FIRED_TIME",                    null: false
    t.bigint  "SCHED_TIME",                    null: false
    t.integer "PRIORITY",                      null: false
    t.string  "STATE",             limit: 16,  null: false
    t.string  "JOB_NAME",          limit: 150
    t.string  "JOB_GROUP",         limit: 150
    t.boolean "IS_NONCONCURRENT"
    t.boolean "REQUESTS_RECOVERY"
    t.index ["SCHED_NAME", "INSTANCE_NAME", "REQUESTS_RECOVERY"], name: "IDX_Scheduling_FT_INST_JOB_REQ_RCVRY"
    t.index ["SCHED_NAME", "INSTANCE_NAME"], name: "IDX_Scheduling_FT_TRIG_INST_NAME"
    t.index ["SCHED_NAME", "JOB_GROUP"], name: "IDX_Scheduling_FT_JG"
    t.index ["SCHED_NAME", "JOB_NAME", "JOB_GROUP"], name: "IDX_Scheduling_FT_J_G"
    t.index ["SCHED_NAME", "TRIGGER_GROUP"], name: "IDX_Scheduling_FT_TG"
    t.index ["SCHED_NAME", "TRIGGER_NAME", "TRIGGER_GROUP"], name: "IDX_Scheduling_FT_T_G"
  end

  create_table "Scheduling_JOB_DETAILS", primary_key: ["SCHED_NAME", "JOB_NAME", "JOB_GROUP"], force: :cascade do |t|
    t.string  "SCHED_NAME",        limit: 100, null: false
    t.string  "JOB_NAME",          limit: 150, null: false
    t.string  "JOB_GROUP",         limit: 150, null: false
    t.string  "DESCRIPTION",       limit: 250
    t.string  "JOB_CLASS_NAME",    limit: 250, null: false
    t.boolean "IS_DURABLE",                    null: false
    t.boolean "IS_NONCONCURRENT",              null: false
    t.boolean "IS_UPDATE_DATA",                null: false
    t.boolean "REQUESTS_RECOVERY",             null: false
    t.string  "JOB_DATA"
  end

  create_table "Scheduling_LOCKS", primary_key: ["SCHED_NAME", "LOCK_NAME"], force: :cascade do |t|
    t.string "SCHED_NAME", limit: 100, null: false
    t.string "LOCK_NAME",  limit: 40,  null: false
  end

  create_table "Scheduling_PAUSED_TRIGGER_GRPS", primary_key: ["SCHED_NAME", "TRIGGER_GROUP"], force: :cascade do |t|
    t.string "SCHED_NAME",    limit: 100, null: false
    t.string "TRIGGER_GROUP", limit: 150, null: false
  end

  create_table "Scheduling_SCHEDULER_STATE", primary_key: ["SCHED_NAME", "INSTANCE_NAME"], force: :cascade do |t|
    t.string "SCHED_NAME",        limit: 100, null: false
    t.string "INSTANCE_NAME",     limit: 200, null: false
    t.bigint "LAST_CHECKIN_TIME",             null: false
    t.bigint "CHECKIN_INTERVAL",              null: false
  end

  create_table "Scheduling_SIMPLE_TRIGGERS", primary_key: ["SCHED_NAME", "TRIGGER_NAME", "TRIGGER_GROUP"], force: :cascade do |t|
    t.string  "SCHED_NAME",      limit: 100, null: false
    t.string  "TRIGGER_NAME",    limit: 150, null: false
    t.string  "TRIGGER_GROUP",   limit: 150, null: false
    t.integer "REPEAT_COUNT",                null: false
    t.bigint  "REPEAT_INTERVAL",             null: false
    t.integer "TIMES_TRIGGERED",             null: false
  end

  create_table "Scheduling_SIMPROP_TRIGGERS", primary_key: ["SCHED_NAME", "TRIGGER_NAME", "TRIGGER_GROUP"], force: :cascade do |t|
    t.string  "SCHED_NAME",    limit: 100,                          null: false
    t.string  "TRIGGER_NAME",  limit: 150,                          null: false
    t.string  "TRIGGER_GROUP", limit: 150,                          null: false
    t.string  "STR_PROP_1",    limit: 512
    t.string  "STR_PROP_2",    limit: 512
    t.string  "STR_PROP_3",    limit: 512
    t.integer "INT_PROP_1"
    t.integer "INT_PROP_2"
    t.bigint  "LONG_PROP_1"
    t.bigint  "LONG_PROP_2"
    t.decimal "DEC_PROP_1",                precision: 13, scale: 4
    t.decimal "DEC_PROP_2",                precision: 13, scale: 4
    t.boolean "BOOL_PROP_1"
    t.boolean "BOOL_PROP_2"
  end

  create_table "Scheduling_TRIGGERS", primary_key: ["SCHED_NAME", "TRIGGER_NAME", "TRIGGER_GROUP"], force: :cascade do |t|
    t.string  "SCHED_NAME",     limit: 100, null: false
    t.string  "TRIGGER_NAME",   limit: 150, null: false
    t.string  "TRIGGER_GROUP",  limit: 150, null: false
    t.string  "JOB_NAME",       limit: 150, null: false
    t.string  "JOB_GROUP",      limit: 150, null: false
    t.string  "DESCRIPTION",    limit: 250
    t.bigint  "NEXT_FIRE_TIME"
    t.bigint  "PREV_FIRE_TIME"
    t.integer "PRIORITY"
    t.string  "TRIGGER_STATE",  limit: 16,  null: false
    t.string  "TRIGGER_TYPE",   limit: 8,   null: false
    t.bigint  "START_TIME",                 null: false
    t.bigint  "END_TIME"
    t.string  "CALENDAR_NAME",  limit: 200
    t.integer "MISFIRE_INSTR"
    t.string  "JOB_DATA"
    t.index ["SCHED_NAME", "CALENDAR_NAME"], name: "IDX_Scheduling_T_C"
    t.index ["SCHED_NAME", "JOB_GROUP"], name: "IDX_Scheduling_T_JG"
    t.index ["SCHED_NAME", "JOB_NAME", "JOB_GROUP"], name: "IDX_Scheduling_T_J"
    t.index ["SCHED_NAME", "MISFIRE_INSTR", "NEXT_FIRE_TIME", "TRIGGER_GROUP", "TRIGGER_STATE"], name: "IDX_Scheduling_T_NFT_ST_MISFIRE_GRP"
    t.index ["SCHED_NAME", "MISFIRE_INSTR", "NEXT_FIRE_TIME", "TRIGGER_STATE"], name: "IDX_Scheduling_T_NFT_ST_MISFIRE"
    t.index ["SCHED_NAME", "MISFIRE_INSTR", "NEXT_FIRE_TIME"], name: "IDX_Scheduling_T_NFT_MISFIRE"
    t.index ["SCHED_NAME", "NEXT_FIRE_TIME"], name: "IDX_Scheduling_T_NEXT_FIRE_TIME"
    t.index ["SCHED_NAME", "TRIGGER_GROUP", "TRIGGER_STATE"], name: "IDX_Scheduling_T_N_G_STATE"
    t.index ["SCHED_NAME", "TRIGGER_GROUP"], name: "IDX_Scheduling_T_G"
    t.index ["SCHED_NAME", "TRIGGER_NAME", "TRIGGER_GROUP", "TRIGGER_STATE"], name: "IDX_Scheduling_T_N_STATE"
    t.index ["SCHED_NAME", "TRIGGER_STATE", "NEXT_FIRE_TIME"], name: "IDX_Scheduling_T_NFT_ST"
    t.index ["SCHED_NAME", "TRIGGER_STATE"], name: "IDX_Scheduling_T_STATE"
  end

  create_table "Search", primary_key: "SearchID", id: :bigint, force: :cascade do |t|
    t.datetime "Started",      null: false
    t.datetime "Pinged",       null: false
    t.bigint   "FilterNodeID", null: false
    t.bigint   "UserID",       null: false
    t.bigint   "ComputerID",   null: false
  end

  create_table "SearsOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.varchar "PoNumber",         limit: 30,                          null: false
    t.varchar "PoNumberWithDate", limit: 30,                          null: false
    t.integer "LocationID",                                           null: false
    t.money   "Commission",                  precision: 19, scale: 4, null: false
    t.boolean "CustomerPickup",                                       null: false
  end

  create_table "SearsOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.integer "LineNumber",                                        null: false
    t.varchar "ItemID",       limit: 300,                          null: false
    t.money   "Commission",               precision: 19, scale: 4, null: false
    t.money   "Shipping",                 precision: 19, scale: 4, null: false
    t.varchar "OnlineStatus", limit: 20,                           null: false
  end

  create_table "SearsStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string "SearsEmail", limit: 75,               null: false
    t.string "Password",   limit: 75,               null: false
    t.string "SecretKey",  limit: 255,              null: false
    t.string "SellerID",   limit: 15,  default: "", null: false
  end

  create_table "ServerMessage", primary_key: "ServerMessageID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                        null: false
    t.integer      "Number",                            null: false
    t.datetime     "Published",                         null: false
    t.boolean      "Active",                            null: false
    t.boolean      "Dismissable",                       null: false
    t.datetime     "Expires"
    t.integer      "ResponseTo"
    t.integer      "ResponseAction"
    t.integer      "EditTo"
    t.string       "Image",          limit: 350,        null: false
    t.string       "PrimaryText",    limit: 30,         null: false
    t.string       "SecondaryText",  limit: 60,         null: false
    t.ntext        "Actions",        limit: 2147483647, null: false
    t.ntext        "Stores",         limit: 2147483647, null: false
    t.ntext        "Shippers",       limit: 2147483647, null: false
    t.index ["Expires"], name: "IX_ServerMessage_Expires"
    t.index ["Number"], name: "IX_ServerMessage_Number", unique: true
    t.index ["RowVersion"], name: "IX_ServerMessage_RowVersion", unique: true
  end

  create_table "ServerMessageSignoff", primary_key: "ServerMessageSignoffID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",      null: false
    t.bigint       "ServerMessageID", null: false
    t.bigint       "UserID",          null: false
    t.bigint       "ComputerID",      null: false
    t.datetime     "Dismissed",       null: false
    t.index ["UserID", "ComputerID", "ServerMessageID"], name: "IX_ServerMessageSignoff", unique: true
  end

  create_table "ServiceStatus", primary_key: "ServiceStatusID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                      null: false
    t.bigint       "ComputerID",                      null: false
    t.integer      "ServiceType",                     null: false
    t.datetime     "LastStartDateTime"
    t.datetime     "LastStopDateTime"
    t.datetime     "LastCheckInDateTime"
    t.string       "ServiceFullName",     limit: 256, null: false
    t.string       "ServiceDisplayName",  limit: 256, null: false
    t.index ["ComputerID", "ServiceType"], name: "IX_ServiceStatus", unique: true
  end

  create_table "ShipSenseKnowledgeBase", primary_key: "Hash", id: :string, limit: 64, collation: SQL_Latin1_General_CP1_CS_AS, force: :cascade do |t|
    t.binary "Entry", limit: 2147483647, null: false
  end

  create_table "Shipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                                                       null: false
    t.bigint       "OrderID",                                                                          null: false
    t.integer      "ShipmentType",                                                                     null: false
    t.float        "ContentWeight",                                                                    null: false
    t.float        "TotalWeight",                                                                      null: false
    t.boolean      "Processed",                                                                        null: false
    t.datetime     "ProcessedDate"
    t.bigint       "ProcessedUserID"
    t.bigint       "ProcessedComputerID"
    t.datetime     "ShipDate",                                                                         null: false
    t.money        "ShipmentCost",                                            precision: 19, scale: 4, null: false
    t.boolean      "Voided",                                                                           null: false
    t.datetime     "VoidedDate"
    t.bigint       "VoidedUserID"
    t.bigint       "VoidedComputerID"
    t.string       "TrackingNumber",                       limit: 50,                                  null: false
    t.boolean      "CustomsGenerated",                                                                 null: false
    t.money        "CustomsValue",                                            precision: 19, scale: 4, null: false
    t.integer      "RequestedLabelFormat",                                                             null: false
    t.integer      "ActualLabelFormat"
    t.string       "ShipFirstName",                        limit: 30,                                  null: false
    t.string       "ShipMiddleName",                       limit: 30,                                  null: false
    t.string       "ShipLastName",                         limit: 30,                                  null: false
    t.string       "ShipCompany",                          limit: 60,                                  null: false
    t.string       "ShipStreet1",                          limit: 60,                                  null: false
    t.string       "ShipStreet2",                          limit: 60,                                  null: false
    t.string       "ShipStreet3",                          limit: 60,                                  null: false
    t.string       "ShipCity",                             limit: 50,                                  null: false
    t.string       "ShipStateProvCode",                    limit: 50,                                  null: false
    t.string       "ShipPostalCode",                       limit: 20,                                  null: false
    t.string       "ShipCountryCode",                      limit: 50,                                  null: false
    t.string       "ShipPhone",                            limit: 25,                                  null: false
    t.string       "ShipEmail",                            limit: 100,                                 null: false
    t.integer      "ShipAddressValidationSuggestionCount",                                             null: false
    t.integer      "ShipAddressValidationStatus",                                                      null: false
    t.string       "ShipAddressValidationError",           limit: 300,                                 null: false
    t.integer      "ShipResidentialStatus",                                                            null: false
    t.integer      "ShipPOBox",                                                                        null: false
    t.integer      "ShipUSTerritory",                                                                  null: false
    t.integer      "ShipMilitaryAddress",                                                              null: false
    t.integer      "ResidentialDetermination",                                                         null: false
    t.boolean      "ResidentialResult",                                                                null: false
    t.bigint       "OriginOriginID",                                                                   null: false
    t.string       "OriginFirstName",                      limit: 30,                                  null: false
    t.string       "OriginMiddleName",                     limit: 30,                                  null: false
    t.string       "OriginLastName",                       limit: 30,                                  null: false
    t.string       "OriginCompany",                        limit: 60,                                  null: false
    t.string       "OriginStreet1",                        limit: 60,                                  null: false
    t.string       "OriginStreet2",                        limit: 60,                                  null: false
    t.string       "OriginStreet3",                        limit: 60,                                  null: false
    t.string       "OriginCity",                           limit: 50,                                  null: false
    t.string       "OriginStateProvCode",                  limit: 50,                                  null: false
    t.string       "OriginPostalCode",                     limit: 20,                                  null: false
    t.string       "OriginCountryCode",                    limit: 50,                                  null: false
    t.string       "OriginPhone",                          limit: 25,                                  null: false
    t.string       "OriginFax",                            limit: 35,                                  null: false
    t.string       "OriginEmail",                          limit: 100,                                 null: false
    t.string       "OriginWebsite",                        limit: 50,                                  null: false
    t.boolean      "ReturnShipment",                                                                   null: false
    t.boolean      "Insurance",                                                                        null: false
    t.integer      "InsuranceProvider",                                                                null: false
    t.integer      "ShipNameParseStatus",                                                              null: false
    t.string       "ShipUnparsedName",                     limit: 100,                                 null: false
    t.integer      "OriginNameParseStatus",                                                            null: false
    t.string       "OriginUnparsedName",                   limit: 100,                                 null: false
    t.integer      "BestRateEvents",                       limit: 1,                                   null: false
    t.integer      "ShipSenseStatus",                                                                  null: false
    t.string       "ShipSenseChangeSets",                                                              null: false
    t.binary       "ShipSenseEntry",                       limit: 2147483647,                          null: false
    t.varchar      "OnlineShipmentID",                     limit: 128,                                 null: false
    t.integer      "BilledType",                                                                       null: false
    t.float        "BilledWeight",                                                                     null: false
    t.index ["ActualLabelFormat"], name: "IX_Shipment_ActualLabelFormat"
    t.index ["OrderID", "Processed", "ShipSenseStatus"], name: "IX_Shipment_OrderID_ShipSenseStatus"
    t.index ["OrderID"], name: "IX_Shipment_OrderID"
    t.index ["Processed", "ProcessedDate"], name: "IX_Shipment_ProcessedOrderID"
    t.index ["RequestedLabelFormat"], name: "IX_Shipment_RequestedLabelFormat"
    t.index ["ReturnShipment"], name: "IX_Shipment_ReturnShipment"
    t.index ["ShipAddressValidationStatus"], name: "IX_Shipment_ShipAddressValidationStatus"
    t.index ["ShipDate"], name: "IX_Shipment_ShipDate"
    t.index ["ShipMilitaryAddress"], name: "IX_Shipment_ShipMilitaryAddress"
    t.index ["ShipPOBox"], name: "IX_Shipment_ShipPOBox"
    t.index ["ShipResidentialStatus"], name: "IX_Shipment_ShipResidentialStatus"
    t.index ["ShipUSTerritory"], name: "IX_Shipment_ShipUSTerritory"
    t.index ["ShipmentType"], name: "IX_Shipment_ShipmentType"
  end

  create_table "ShipmentCustomsItem", primary_key: "ShipmentCustomsItemID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                           null: false
    t.bigint       "ShipmentID",                                           null: false
    t.string       "Description",     limit: 150,                          null: false
    t.float        "Quantity",                                             null: false
    t.float        "Weight",                                               null: false
    t.money        "UnitValue",                   precision: 19, scale: 4, null: false
    t.string       "CountryOfOrigin", limit: 50,                           null: false
    t.varchar      "HarmonizedCode",  limit: 14,                           null: false
    t.integer      "NumberOfPieces",                                       null: false
    t.money        "UnitPriceAmount",             precision: 19, scale: 4, null: false
    t.index ["ShipmentID"], name: "IX_ShipmentCustomsItem_ShipmentID"
  end

  create_table "ShippingDefaultsRule", primary_key: "ShippingDefaultsRuleID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",        null: false
    t.integer      "ShipmentType",      null: false
    t.bigint       "FilterNodeID",      null: false
    t.bigint       "ShippingProfileID", null: false
    t.integer      "Position",          null: false
  end

  create_table "ShippingOrigin", primary_key: "ShippingOriginID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                null: false
    t.string       "Description",   limit: 50,  null: false
    t.string       "FirstName",     limit: 30,  null: false
    t.string       "MiddleName",    limit: 30,  null: false
    t.string       "LastName",      limit: 30,  null: false
    t.string       "Company",       limit: 35,  null: false
    t.string       "Street1",       limit: 60,  null: false
    t.string       "Street2",       limit: 60,  null: false
    t.string       "Street3",       limit: 60,  null: false
    t.string       "City",          limit: 50,  null: false
    t.string       "StateProvCode", limit: 50,  null: false
    t.string       "PostalCode",    limit: 20,  null: false
    t.string       "CountryCode",   limit: 50,  null: false
    t.string       "Phone",         limit: 25,  null: false
    t.string       "Fax",           limit: 35,  null: false
    t.string       "Email",         limit: 100, null: false
    t.string       "Website",       limit: 50,  null: false
    t.index ["Description"], name: "IX_ShippingOrigin_Description", unique: true
  end

  create_table "ShippingPrintOutput", primary_key: "ShippingPrintOutputID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",              null: false
    t.integer      "ShipmentType",            null: false
    t.string       "Name",         limit: 50, null: false
  end

  create_table "ShippingPrintOutputRule", primary_key: "ShippingPrintOutputRuleID", id: :bigint, force: :cascade do |t|
    t.bigint "ShippingPrintOutputID", null: false
    t.bigint "FilterNodeID",          null: false
    t.bigint "TemplateID",            null: false
  end

  create_table "ShippingProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                                      null: false
    t.string       "Name",                        limit: 50,                          null: false
    t.integer      "ShipmentType",                                                    null: false
    t.boolean      "ShipmentTypePrimary",                                             null: false
    t.bigint       "OriginID"
    t.boolean      "Insurance"
    t.integer      "InsuranceInitialValueSource"
    t.money        "InsuranceInitialValueAmount",            precision: 19, scale: 4
    t.boolean      "ReturnShipment"
    t.integer      "RequestedLabelFormat"
  end

  create_table "ShippingProviderRule", primary_key: "ShippingProviderRuleID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",   null: false
    t.bigint       "FilterNodeID", null: false
    t.integer      "ShipmentType", null: false
  end

  create_table "ShippingSettings", primary_key: "ShippingSettingsID", id: :boolean, force: :cascade do |t|
    t.varchar  "Activated",                        limit: 45,                  null: false
    t.varchar  "Configured",                       limit: 45,                  null: false
    t.varchar  "Excluded",                         limit: 45,                  null: false
    t.integer  "DefaultType",                                                  null: false
    t.integer  "BlankPhoneOption",                                             null: false
    t.string   "BlankPhoneNumber",                 limit: 16,                  null: false
    t.string   "InsurancePolicy",                  limit: 40,                  null: false
    t.datetime "InsuranceLastAgreed"
    t.string   "FedExUsername",                    limit: 50
    t.string   "FedExPassword",                    limit: 50
    t.boolean  "FedExMaskAccount",                                             null: false
    t.boolean  "FedExThermalDocTab",                                           null: false
    t.integer  "FedExThermalDocTabType",                                       null: false
    t.integer  "FedExInsuranceProvider",                                       null: false
    t.boolean  "FedExInsurancePennyOne",                                       null: false
    t.string   "UpsAccessKey",                     limit: 50
    t.integer  "UpsInsuranceProvider",                                         null: false
    t.boolean  "UpsInsurancePennyOne",                                         null: false
    t.boolean  "EndiciaCustomsCertify",                                        null: false
    t.string   "EndiciaCustomsSigner",             limit: 100,                 null: false
    t.boolean  "EndiciaThermalDocTab",                                         null: false
    t.integer  "EndiciaThermalDocTabType",                                     null: false
    t.boolean  "EndiciaAutomaticExpress1",                                     null: false
    t.bigint   "EndiciaAutomaticExpress1Account",                              null: false
    t.integer  "EndiciaInsuranceProvider",                                     null: false
    t.boolean  "WorldShipLaunch",                                              null: false
    t.boolean  "UspsAutomaticExpress1",                                        null: false
    t.bigint   "UspsAutomaticExpress1Account",                                 null: false
    t.integer  "UspsInsuranceProvider",                                        null: false
    t.boolean  "Express1EndiciaCustomsCertify",                                null: false
    t.string   "Express1EndiciaCustomsSigner",     limit: 100,                 null: false
    t.boolean  "Express1EndiciaThermalDocTab",                                 null: false
    t.integer  "Express1EndiciaThermalDocTabType",                             null: false
    t.boolean  "Express1EndiciaSingleSource",                                  null: false
    t.integer  "OnTracInsuranceProvider",                                      null: false
    t.boolean  "OnTracInsurancePennyOne",                                      null: false
    t.integer  "iParcelInsuranceProvider",                                     null: false
    t.boolean  "iParcelInsurancePennyOne",                                     null: false
    t.boolean  "Express1UspsSingleSource",                                     null: false
    t.boolean  "UpsMailInnovationsEnabled",                                    null: false
    t.boolean  "WorldShipMailInnovationsEnabled",                              null: false
    t.string   "BestRateExcludedShipmentTypes",    limit: 30,                  null: false
    t.boolean  "ShipSenseEnabled",                                             null: false
    t.string   "ShipSenseUniquenessXml",                                       null: false
    t.bigint   "ShipSenseProcessedShipmentID",                                 null: false
    t.bigint   "ShipSenseEndShipmentID",                                       null: false
    t.boolean  "AutoCreateShipments",                                          null: false
    t.boolean  "FedExFimsEnabled",                             default: false, null: false
    t.string   "FedExFimsUsername",                limit: 50,  default: "",    null: false
    t.string   "FedExFimsPassword",                limit: 50,  default: "",    null: false
    t.integer  "ShipmentEditLimit",                                            null: false
  end

  create_table "ShopSiteStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "Username",         limit: 50,  null: false
    t.string  "Password",         limit: 50,  null: false
    t.string  "CgiUrl",           limit: 350, null: false
    t.boolean "RequireSSL",                   null: false
    t.integer "DownloadPageSize",             null: false
    t.integer "RequestTimeout",               null: false
  end

  create_table "ShopifyOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShopifyOrderID",        null: false
    t.integer "FulfillmentStatusCode", null: false
    t.integer "PaymentStatusCode",     null: false
  end

  create_table "ShopifyOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.bigint "ShopifyOrderItemId", null: false
    t.bigint "ShopifyProductId",   null: false
  end

  create_table "ShopifyStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "ShopifyShopUrlName",             limit: 100, null: false
    t.string  "ShopifyShopDisplayName",         limit: 100, null: false
    t.string  "ShopifyAccessToken",             limit: 255, null: false
    t.integer "ShopifyRequestedShippingOption",             null: false
    t.string  "ApiKey",                         limit: 100, null: false
    t.string  "Password",                       limit: 100, null: false
  end

  create_table "SparkPayStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string "Token",       limit: 70,  null: false
    t.string "StoreUrl",    limit: 350, null: false
    t.string "StatusCodes"
  end

  create_table "StatusPreset", primary_key: "StatusPresetID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",               null: false
    t.bigint       "StoreID"
    t.integer      "StatusTarget",             null: false
    t.string       "StatusText",   limit: 300, null: false
    t.boolean      "IsDefault",                null: false
  end

  create_table "Store", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                  null: false
    t.string       "License",                  limit: 150,        null: false
    t.text         "Edition",                  limit: 2147483647, null: false
    t.integer      "TypeCode",                                    null: false
    t.boolean      "Enabled",                                     null: false
    t.boolean      "SetupComplete",                               null: false
    t.string       "StoreName",                limit: 75,         null: false
    t.string       "Company",                  limit: 60,         null: false
    t.string       "Street1",                  limit: 60,         null: false
    t.string       "Street2",                  limit: 60,         null: false
    t.string       "Street3",                  limit: 60,         null: false
    t.string       "City",                     limit: 50,         null: false
    t.string       "StateProvCode",            limit: 50,         null: false
    t.string       "PostalCode",               limit: 20,         null: false
    t.string       "CountryCode",              limit: 50,         null: false
    t.string       "Phone",                    limit: 25,         null: false
    t.string       "Fax",                      limit: 35,         null: false
    t.string       "Email",                    limit: 100,        null: false
    t.string       "Website",                  limit: 50,         null: false
    t.boolean      "AutoDownload",                                null: false
    t.integer      "AutoDownloadMinutes",                         null: false
    t.boolean      "AutoDownloadOnlyAway",                        null: false
    t.integer      "AddressValidationSetting",                    null: false
    t.text         "ComputerDownloadPolicy",   limit: 2147483647, null: false
    t.bigint       "DefaultEmailAccountID",                       null: false
    t.string       "ManualOrderPrefix",        limit: 10,         null: false
    t.string       "ManualOrderPostfix",       limit: 10,         null: false
    t.integer      "InitialDownloadDays"
    t.bigint       "InitialDownloadOrder"
    t.index ["StoreName"], name: "IX_Store_StoreName", unique: true
  end

  create_table "SystemData", primary_key: "SystemDataID", id: :boolean, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                       null: false
    t.uuid         "DatabaseID",                       null: false
    t.datetime     "DateFiltersLastUpdate",            null: false
    t.varchar      "TemplateVersion",       limit: 30, null: false
  end

  create_table "Template", primary_key: "TemplateID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                                 null: false
    t.bigint       "ParentFolderID",                             null: false
    t.string       "Name",                    limit: 100,        null: false
    t.text         "Xsl",                     limit: 2147483647, null: false
    t.integer      "Type",                                       null: false
    t.integer      "Context",                                    null: false
    t.integer      "OutputFormat",                               null: false
    t.string       "OutputEncoding",          limit: 20,         null: false
    t.float        "PageMarginLeft",                             null: false
    t.float        "PageMarginRight",                            null: false
    t.float        "PageMarginBottom",                           null: false
    t.float        "PageMarginTop",                              null: false
    t.float        "PageWidth",                                  null: false
    t.float        "PageHeight",                                 null: false
    t.bigint       "LabelSheetID",                               null: false
    t.integer      "PrintCopies",                                null: false
    t.boolean      "PrintCollate",                               null: false
    t.string       "SaveFileName",            limit: 500,        null: false
    t.string       "SaveFileFolder",          limit: 500,        null: false
    t.integer      "SaveFilePrompt",                             null: false
    t.boolean      "SaveFileBOM",                                null: false
    t.boolean      "SaveFileOnlineResources",                    null: false
  end

  create_table "TemplateComputerSettings", primary_key: "TemplateComputerSettingsID", id: :bigint, force: :cascade do |t|
    t.bigint  "TemplateID",              null: false
    t.bigint  "ComputerID",              null: false
    t.string  "PrinterName", limit: 350, null: false
    t.integer "PaperSource",             null: false
  end

  create_table "TemplateFolder", primary_key: "TemplateFolderID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                 null: false
    t.bigint       "ParentFolderID"
    t.string       "Name",           limit: 100, null: false
  end

  create_table "TemplateStoreSettings", primary_key: "TemplateStoreSettingsID", id: :bigint, force: :cascade do |t|
    t.bigint  "TemplateID",                         null: false
    t.bigint  "StoreID"
    t.boolean "EmailUseDefault",                    null: false
    t.bigint  "EmailAccountID",                     null: false
    t.text    "EmailTo",         limit: 2147483647, null: false
    t.text    "EmailCc",         limit: 2147483647, null: false
    t.text    "EmailBcc",        limit: 2147483647, null: false
    t.string  "EmailSubject",    limit: 500,        null: false
    t.index ["TemplateID", "StoreID"], name: "IX_TemplateStoreSettings", unique: true
  end

  create_table "TemplateUserSettings", primary_key: "TemplateUserSettingsID", id: :bigint, force: :cascade do |t|
    t.bigint  "TemplateID",                     null: false
    t.bigint  "UserID",                         null: false
    t.integer "PreviewSource",                  null: false
    t.integer "PreviewCount",                   null: false
    t.bigint  "PreviewFilterNodeID"
    t.string  "PreviewZoom",         limit: 10, null: false
  end

  create_table "ThreeDCartOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.bigint "ThreeDCartOrderID", null: false
  end

  create_table "ThreeDCartOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.bigint "ThreeDCartShipmentID", null: false
  end

  create_table "ThreeDCartStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "StoreUrl",                         limit: 110, null: false
    t.string  "ApiUserKey",                       limit: 65,  null: false
    t.string  "TimeZoneID",                       limit: 100
    t.string  "StatusCodes"
    t.integer "DownloadModifiedNumberOfDaysBack",             null: false
    t.boolean "RestUser",                                     null: false
  end

  create_table "UpsAccount", primary_key: "UpsAccountID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                null: false
    t.string       "Description",   limit: 50,  null: false
    t.string       "AccountNumber", limit: 10,  null: false
    t.string       "UserID",        limit: 25,  null: false
    t.string       "Password",      limit: 25,  null: false
    t.integer      "RateType",                  null: false
    t.boolean      "InvoiceAuth",               null: false
    t.string       "FirstName",     limit: 30,  null: false
    t.string       "MiddleName",    limit: 30,  null: false
    t.string       "LastName",      limit: 30,  null: false
    t.string       "Company",       limit: 30,  null: false
    t.string       "Street1",       limit: 60,  null: false
    t.string       "Street2",       limit: 60,  null: false
    t.string       "Street3",       limit: 60,  null: false
    t.string       "City",          limit: 50,  null: false
    t.string       "StateProvCode", limit: 50,  null: false
    t.string       "PostalCode",    limit: 20,  null: false
    t.string       "CountryCode",   limit: 50,  null: false
    t.string       "Phone",         limit: 25,  null: false
    t.string       "Email",         limit: 100, null: false
    t.string       "Website",       limit: 50,  null: false
    t.integer      "PromoStatus",   limit: 1,   null: false
  end

  create_table "UpsPackage", primary_key: "UpsPackageID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShipmentID",                                                           null: false
    t.integer "PackagingType",                                                        null: false
    t.float   "Weight",                                                               null: false
    t.bigint  "DimsProfileID",                                                        null: false
    t.float   "DimsLength",                                                           null: false
    t.float   "DimsWidth",                                                            null: false
    t.float   "DimsHeight",                                                           null: false
    t.float   "DimsWeight",                                                           null: false
    t.boolean "DimsAddWeight",                                                        null: false
    t.boolean "Insurance",                                                            null: false
    t.money   "InsuranceValue",                              precision: 19, scale: 4, null: false
    t.boolean "InsurancePennyOne",                                                    null: false
    t.money   "DeclaredValue",                               precision: 19, scale: 4, null: false
    t.string  "TrackingNumber",                   limit: 50,                          null: false
    t.string  "UspsTrackingNumber",               limit: 50,                          null: false
    t.boolean "AdditionalHandlingEnabled",                                            null: false
    t.boolean "VerbalConfirmationEnabled",                                            null: false
    t.string  "VerbalConfirmationName",           limit: 35,                          null: false
    t.string  "VerbalConfirmationPhone",          limit: 15,                          null: false
    t.string  "VerbalConfirmationPhoneExtension", limit: 4,                           null: false
    t.boolean "DryIceEnabled",                                                        null: false
    t.integer "DryIceRegulationSet",                                                  null: false
    t.float   "DryIceWeight",                                                         null: false
    t.boolean "DryIceIsForMedicalUse",                                                null: false
    t.index ["PackagingType"], name: "IX_UpsPackage_PackagingType"
    t.index ["ShipmentID"], name: "IX_UpsPackage_ShipmentID"
  end

  create_table "UpsProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "UpsAccountID"
    t.integer "Service"
    t.boolean "SaturdayDelivery"
    t.integer "ResidentialDetermination"
    t.integer "DeliveryConfirmation"
    t.string  "ReferenceNumber",                  limit: 300
    t.string  "ReferenceNumber2",                 limit: 300
    t.integer "PayorType"
    t.varchar "PayorAccount",                     limit: 10
    t.string  "PayorPostalCode",                  limit: 20
    t.string  "PayorCountryCode",                 limit: 50
    t.integer "EmailNotifySender"
    t.integer "EmailNotifyRecipient"
    t.integer "EmailNotifyOther"
    t.string  "EmailNotifyOtherAddress",          limit: 100
    t.string  "EmailNotifyFrom",                  limit: 100
    t.integer "EmailNotifySubject"
    t.string  "EmailNotifyMessage",               limit: 120
    t.integer "ReturnService"
    t.string  "ReturnUndeliverableEmail",         limit: 100
    t.string  "ReturnContents",                   limit: 300
    t.integer "Endorsement"
    t.integer "Subclassification"
    t.boolean "PaperlessAdditionalDocumentation"
    t.boolean "ShipperRelease"
    t.boolean "CarbonNeutral"
    t.boolean "CommercialPaperlessInvoice"
    t.string  "CostCenter",                       limit: 100
    t.integer "IrregularIndicator"
    t.string  "Cn22Number",                       limit: 255
    t.integer "ShipmentChargeType"
    t.varchar "ShipmentChargeAccount",            limit: 10
    t.string  "ShipmentChargePostalCode",         limit: 20
    t.string  "ShipmentChargeCountryCode",        limit: 50
    t.string  "UspsPackageID",                    limit: 100
  end

  create_table "UpsProfilePackage", primary_key: "UpsProfilePackageID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShippingProfileID",                           null: false
    t.integer "PackagingType"
    t.float   "Weight"
    t.bigint  "DimsProfileID"
    t.float   "DimsLength"
    t.float   "DimsWidth"
    t.float   "DimsHeight"
    t.float   "DimsWeight"
    t.boolean "DimsAddWeight"
    t.boolean "AdditionalHandlingEnabled"
    t.boolean "VerbalConfirmationEnabled"
    t.string  "VerbalConfirmationName",           limit: 35
    t.string  "VerbalConfirmationPhone",          limit: 15
    t.string  "VerbalConfirmationPhoneExtension", limit: 4
    t.boolean "DryIceEnabled"
    t.integer "DryIceRegulationSet"
    t.float   "DryIceWeight"
    t.boolean "DryIceIsForMedicalUse"
  end

  create_table "UpsShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.bigint  "UpsAccountID",                                                          null: false
    t.integer "Service",                                                               null: false
    t.boolean "SaturdayDelivery",                                                      null: false
    t.boolean "CodEnabled",                                                            null: false
    t.money   "CodAmount",                                    precision: 19, scale: 4, null: false
    t.integer "CodPaymentType",                                                        null: false
    t.integer "DeliveryConfirmation",                                                  null: false
    t.string  "ReferenceNumber",                  limit: 300,                          null: false
    t.string  "ReferenceNumber2",                 limit: 300,                          null: false
    t.integer "PayorType",                                                             null: false
    t.varchar "PayorAccount",                     limit: 10,                           null: false
    t.string  "PayorPostalCode",                  limit: 20,                           null: false
    t.string  "PayorCountryCode",                 limit: 50,                           null: false
    t.integer "EmailNotifySender",                                                     null: false
    t.integer "EmailNotifyRecipient",                                                  null: false
    t.integer "EmailNotifyOther",                                                      null: false
    t.string  "EmailNotifyOtherAddress",          limit: 100,                          null: false
    t.string  "EmailNotifyFrom",                  limit: 100,                          null: false
    t.integer "EmailNotifySubject",                                                    null: false
    t.string  "EmailNotifyMessage",               limit: 120,                          null: false
    t.boolean "CustomsDocumentsOnly",                                                  null: false
    t.string  "CustomsDescription",               limit: 150,                          null: false
    t.boolean "CommercialPaperlessInvoice",                                            null: false
    t.integer "CommercialInvoiceTermsOfSale",                                          null: false
    t.integer "CommercialInvoicePurpose",                                              null: false
    t.string  "CommercialInvoiceComments",        limit: 200,                          null: false
    t.money   "CommercialInvoiceFreight",                     precision: 19, scale: 4, null: false
    t.money   "CommercialInvoiceInsurance",                   precision: 19, scale: 4, null: false
    t.money   "CommercialInvoiceOther",                       precision: 19, scale: 4, null: false
    t.integer "WorldShipStatus",                                                       null: false
    t.money   "PublishedCharges",                             precision: 19, scale: 4, null: false
    t.boolean "NegotiatedRate",                                                        null: false
    t.integer "ReturnService",                                                         null: false
    t.string  "ReturnUndeliverableEmail",         limit: 100,                          null: false
    t.string  "ReturnContents",                   limit: 300,                          null: false
    t.string  "UspsTrackingNumber",               limit: 50,                           null: false
    t.integer "Endorsement",                                                           null: false
    t.integer "Subclassification",                                                     null: false
    t.boolean "PaperlessAdditionalDocumentation",                                      null: false
    t.boolean "ShipperRelease",                                                        null: false
    t.boolean "CarbonNeutral",                                                         null: false
    t.string  "CostCenter",                       limit: 100,                          null: false
    t.integer "IrregularIndicator",                                                    null: false
    t.string  "Cn22Number",                       limit: 255,                          null: false
    t.integer "ShipmentChargeType",                                                    null: false
    t.varchar "ShipmentChargeAccount",            limit: 10,                           null: false
    t.string  "ShipmentChargePostalCode",         limit: 20,                           null: false
    t.string  "ShipmentChargeCountryCode",        limit: 50,                           null: false
    t.string  "UspsPackageID",                    limit: 100,                          null: false
    t.integer "RequestedLabelFormat",                                                  null: false
    t.index ["DeliveryConfirmation"], name: "IX_UpsShipment_DeliveryConfirmation"
    t.index ["Service"], name: "IX_UpsShipment_Service"
  end

  create_table "User", primary_key: "UserID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",             null: false
    t.string       "Username",   limit: 30,  null: false
    t.string       "Password",   limit: 32,  null: false
    t.string       "Email",      limit: 255, null: false
    t.boolean      "IsAdmin",                null: false
    t.boolean      "IsDeleted",              null: false
    t.index ["Username"], name: "IX_User_Username", unique: true
  end

  create_table "UserColumnSettings", primary_key: "UserColumnSettingsID", id: :bigint, force: :cascade do |t|
    t.uuid    "SettingsKey",        null: false
    t.bigint  "UserID",             null: false
    t.integer "InitialSortType",    null: false
    t.bigint  "GridColumnLayoutID", null: false
    t.index ["UserID", "SettingsKey"], name: "IX_UserColumnSettings", unique: true
  end

  create_table "UserSettings", primary_key: "UserID", id: :bigint, force: :cascade do |t|
    t.integer  "DisplayColorScheme",                                null: false
    t.boolean  "DisplaySystemTray",                                 null: false
    t.binary   "WindowLayout",                   limit: 2147483647, null: false
    t.string   "GridMenuLayout"
    t.boolean  "FilterInitialUseLastActive",                        null: false
    t.bigint   "FilterInitialSpecified",                            null: false
    t.integer  "FilterInitialSortType",                             null: false
    t.bigint   "OrderFilterLastActive",                             null: false
    t.string   "OrderFilterExpandedFolders"
    t.integer  "ShippingWeightFormat",                              null: false
    t.string   "TemplateExpandedFolders"
    t.bigint   "TemplateLastSelected",                              null: false
    t.bigint   "CustomerFilterLastActive",                          null: false
    t.string   "CustomerFilterExpandedFolders"
    t.datetime "NextGlobalPostNotificationDate",                    null: false
    t.integer  "SingleScanSettings",                                null: false
    t.boolean  "AutoWeigh",                                         null: false
  end

  create_table "UspsAccount", primary_key: "UspsAccountID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                         null: false
    t.string       "Description",            limit: 50,  null: false
    t.string       "Username",               limit: 50,  null: false
    t.string       "Password",               limit: 100, null: false
    t.string       "FirstName",              limit: 30,  null: false
    t.string       "MiddleName",             limit: 30,  null: false
    t.string       "LastName",               limit: 30,  null: false
    t.string       "Company",                limit: 30,  null: false
    t.string       "Street1",                limit: 60,  null: false
    t.string       "Street2",                limit: 60,  null: false
    t.string       "Street3",                limit: 60,  null: false
    t.string       "City",                   limit: 50,  null: false
    t.string       "StateProvCode",          limit: 50,  null: false
    t.string       "PostalCode",             limit: 20,  null: false
    t.string       "CountryCode",            limit: 50,  null: false
    t.string       "Phone",                  limit: 25,  null: false
    t.string       "Email",                  limit: 100, null: false
    t.string       "Website",                limit: 50,  null: false
    t.string       "MailingPostalCode",      limit: 20,  null: false
    t.integer      "UspsReseller",                       null: false
    t.integer      "ContractType",                       null: false
    t.datetime     "CreatedDate",                        null: false
    t.integer      "PendingInitialAccount",              null: false
    t.integer      "GlobalPostAvailability",             null: false
  end

  create_table "UspsProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "UspsAccountID"
    t.boolean "HidePostage"
    t.boolean "RequireFullAddressValidation"
    t.boolean "RateShop"
  end

  create_table "UspsScanForm", primary_key: "UspsScanFormID", id: :bigint, force: :cascade do |t|
    t.bigint   "UspsAccountID",                      null: false
    t.varchar  "ScanFormTransactionID", limit: 100,  null: false
    t.varchar  "ScanFormUrl",           limit: 2048, null: false
    t.datetime "CreatedDate",                        null: false
    t.bigint   "ScanFormBatchID",                    null: false
    t.string   "Description",           limit: 100,  null: false
  end

  create_table "UspsShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.bigint  "UspsAccountID",                null: false
    t.boolean "HidePostage",                  null: false
    t.boolean "RequireFullAddressValidation", null: false
    t.uuid    "IntegratorTransactionID",      null: false
    t.uuid    "UspsTransactionID",            null: false
    t.bigint  "OriginalUspsAccountID"
    t.bigint  "ScanFormBatchID"
    t.integer "RequestedLabelFormat",         null: false
    t.boolean "RateShop",                     null: false
  end

  create_table "ValidatedAddress", primary_key: "ValidatedAddressID", id: :bigint, force: :cascade do |t|
    t.bigint  "ConsumerID",                   null: false
    t.string  "AddressPrefix",     limit: 10, null: false
    t.boolean "IsOriginal",                   null: false
    t.string  "Street1",           limit: 60, null: false
    t.string  "Street2",           limit: 60, null: false
    t.string  "Street3",           limit: 60, null: false
    t.string  "City",              limit: 50, null: false
    t.string  "StateProvCode",     limit: 50, null: false
    t.string  "PostalCode",        limit: 20, null: false
    t.string  "CountryCode",       limit: 50, null: false
    t.integer "ResidentialStatus",            null: false
    t.integer "POBox",                        null: false
    t.integer "USTerritory",                  null: false
    t.integer "MilitaryAddress",              null: false
    t.index ["ConsumerID", "AddressPrefix"], name: "IX_ValidatedAddress_ConsumerIDAddressPrefix"
  end

  create_table "VersionSignoff", primary_key: "VersionSignoffID", id: :bigint, force: :cascade do |t|
    t.string "Version",    limit: 30, null: false
    t.bigint "UserID",                null: false
    t.bigint "ComputerID",            null: false
    t.index ["ComputerID", "UserID"], name: "IX_VersionSignoff", unique: true
  end

  create_table "VolusionStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.varchar "StoreUrl",              limit: 255, null: false
    t.varchar "WebUserName",           limit: 50,  null: false
    t.varchar "WebPassword",           limit: 70,  null: false
    t.varchar "ApiPassword",           limit: 100, null: false
    t.string  "PaymentMethods",                    null: false
    t.string  "ShipmentMethods",                   null: false
    t.varchar "DownloadOrderStatuses", limit: 255, null: false
    t.varchar "ServerTimeZone",        limit: 30,  null: false
    t.boolean "ServerTimeZoneDST",                 null: false
  end

  create_table "WalmartOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.varchar  "PurchaseOrderID",             limit: 32, null: false
    t.varchar  "CustomerOrderID",             limit: 50, null: false
    t.datetime "EstimatedDeliveryDate",                  null: false
    t.datetime "EstimatedShipDate",                      null: false
    t.string   "RequestedShippingMethodCode", limit: 12, null: false
    t.index ["CustomerOrderID"], name: "IX_Auto_CustomerOrderId"
    t.index ["EstimatedDeliveryDate"], name: "IX_Auto_EstimatedDeliveryDate"
    t.index ["EstimatedShipDate"], name: "IX_Auto_EstimatedShipDate"
    t.index ["PurchaseOrderID"], name: "IX_Auto_PurchaseOrderId"
    t.index ["RequestedShippingMethodCode"], name: "IX_Auto_RequestedShippingMethodCode"
  end

  create_table "WalmartOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.string "LineNumber",   limit: 20, null: false
    t.string "OnlineStatus", limit: 20, null: false
  end

  create_table "WalmartStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.string  "ConsumerID",                       limit: 50,   null: false
    t.string  "PrivateKey",                       limit: 2000, null: false
    t.integer "DownloadModifiedNumberOfDaysBack",              null: false
  end

  create_table "WorldShipGoods", primary_key: "WorldShipGoodsID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShipmentID",                                                 null: false
    t.bigint  "ShipmentCustomsItemID",                                      null: false
    t.string  "Description",           limit: 150,                          null: false
    t.varchar "TariffCode",            limit: 15,                           null: false
    t.varchar "CountryOfOrigin",       limit: 50,                           null: false
    t.integer "Units",                                                      null: false
    t.varchar "UnitOfMeasure",         limit: 5,                            null: false
    t.money   "UnitPrice",                         precision: 19, scale: 4, null: false
    t.float   "Weight",                                                     null: false
    t.varchar "InvoiceCurrencyCode",   limit: 3
  end

  create_table "WorldShipPackage", primary_key: "UpsPackageID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShipmentID",                                                                     null: false
    t.varchar "PackageType",                   limit: 35,                                       null: false
    t.float   "Weight",                                                                         null: false
    t.string  "ReferenceNumber",               limit: 35,                                       null: false
    t.string  "ReferenceNumber2",              limit: 35,                                       null: false
    t.char    "CodOption",                     limit: 1,                                        null: false
    t.money   "CodAmount",                                 precision: 19, scale: 4,             null: false
    t.char    "CodCashOnly",                   limit: 1,                                        null: false
    t.char    "DeliveryConfirmation",          limit: 1,                                        null: false
    t.char    "DeliveryConfirmationSignature", limit: 1,                                        null: false
    t.char    "DeliveryConfirmationAdult",     limit: 1,                                        null: false
    t.integer "Length",                                                             default: 0, null: false
    t.integer "Width",                                                                          null: false
    t.integer "Height",                                                                         null: false
    t.float   "DeclaredValueAmount"
    t.nchar   "DeclaredValueOption",           limit: 2
    t.string  "CN22GoodsType",                 limit: 50
    t.string  "CN22Description",               limit: 100
    t.string  "PostalSubClass",                limit: 50
    t.char    "MIDeliveryConfirmation",        limit: 1
    t.char    "QvnOption",                     limit: 1
    t.string  "QvnFrom",                       limit: 35
    t.string  "QvnSubjectLine",                limit: 18
    t.string  "QvnMemo",                       limit: 150
    t.char    "Qvn1ShipNotify",                limit: 1
    t.string  "Qvn1ContactName",               limit: 35
    t.string  "Qvn1Email",                     limit: 100
    t.char    "Qvn2ShipNotify",                limit: 1
    t.string  "Qvn2ContactName",               limit: 35
    t.string  "Qvn2Email",                     limit: 100
    t.char    "Qvn3ShipNotify",                limit: 1
    t.string  "Qvn3ContactName",               limit: 35
    t.string  "Qvn3Email",                     limit: 100
    t.char    "ShipperRelease",                limit: 1
    t.char    "AdditionalHandlingEnabled",     limit: 1
    t.char    "VerbalConfirmationOption",      limit: 1
    t.string  "VerbalConfirmationContactName", limit: 35
    t.string  "VerbalConfirmationTelephone",   limit: 15
    t.string  "DryIceRegulationSet",           limit: 5
    t.float   "DryIceWeight"
    t.char    "DryIceMedicalPurpose",          limit: 1
    t.char    "DryIceOption",                  limit: 1
    t.string  "DryIceWeightUnitOfMeasure",     limit: 10
    t.index ["ShipmentID"], name: "IX_WorldShipPackage_ShipmentID"
  end

  create_table "WorldShipProcessed", primary_key: "WorldShipProcessedID", id: :bigint, force: :cascade do |t|
    t.string       "ShipmentID",           limit: 50
    t.ss_timestamp "RowVersion",                      null: false
    t.float        "PublishedCharges",                null: false
    t.float        "NegotiatedCharges",               null: false
    t.string       "TrackingNumber",       limit: 50
    t.string       "UspsTrackingNumber",   limit: 50
    t.string       "ServiceType",          limit: 50
    t.string       "PackageType",          limit: 50
    t.string       "UpsPackageID",         limit: 20
    t.float        "DeclaredValueAmount"
    t.nchar        "DeclaredValueOption",  limit: 2
    t.string       "WorldShipShipmentID",  limit: 50
    t.string       "VoidIndicator",        limit: 50
    t.string       "NumberOfPackages",     limit: 50
    t.string       "LeadTrackingNumber",   limit: 50
    t.bigint       "ShipmentIdCalculated"
  end

  create_table "WorldShipShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.string  "OrderNumber",                   limit: 50,                           null: false
    t.string  "FromCompanyOrName",             limit: 35,                           null: false
    t.string  "FromAttention",                 limit: 35,                           null: false
    t.string  "FromAddress1",                  limit: 60,                           null: false
    t.string  "FromAddress2",                  limit: 60,                           null: false
    t.string  "FromAddress3",                  limit: 60,                           null: false
    t.varchar "FromCountryCode",               limit: 50,                           null: false
    t.varchar "FromPostalCode",                limit: 20,                           null: false
    t.string  "FromCity",                      limit: 50,                           null: false
    t.varchar "FromStateProvCode",             limit: 50,                           null: false
    t.varchar "FromTelephone",                 limit: 25,                           null: false
    t.string  "FromEmail",                     limit: 100,                          null: false
    t.varchar "FromAccountNumber",             limit: 10,                           null: false
    t.string  "ToCustomerID",                  limit: 30,                           null: false
    t.string  "ToCompanyOrName",               limit: 35,                           null: false
    t.string  "ToAttention",                   limit: 35,                           null: false
    t.string  "ToAddress1",                    limit: 60,                           null: false
    t.string  "ToAddress2",                    limit: 60,                           null: false
    t.string  "ToAddress3",                    limit: 60,                           null: false
    t.varchar "ToCountryCode",                 limit: 50,                           null: false
    t.varchar "ToPostalCode",                  limit: 20,                           null: false
    t.string  "ToCity",                        limit: 50,                           null: false
    t.varchar "ToStateProvCode",               limit: 50,                           null: false
    t.varchar "ToTelephone",                   limit: 25,                           null: false
    t.string  "ToEmail",                       limit: 100,                          null: false
    t.varchar "ToAccountNumber",               limit: 10,                           null: false
    t.char    "ToResidential",                 limit: 1,                            null: false
    t.varchar "ServiceType",                   limit: 3,                            null: false
    t.varchar "BillTransportationTo",          limit: 20,                           null: false
    t.char    "SaturdayDelivery",              limit: 1,                            null: false
    t.char    "QvnOption",                     limit: 1,                            null: false
    t.string  "QvnFrom",                       limit: 35
    t.string  "QvnSubjectLine",                limit: 18
    t.string  "QvnMemo",                       limit: 150
    t.char    "Qvn1ShipNotify",                limit: 1,                            null: false
    t.char    "Qvn1DeliveryNotify",            limit: 1,                            null: false
    t.char    "Qvn1ExceptionNotify",           limit: 1,                            null: false
    t.string  "Qvn1ContactName",               limit: 35,                           null: false
    t.string  "Qvn1Email",                     limit: 100,                          null: false
    t.char    "Qvn2ShipNotify",                limit: 1,                            null: false
    t.char    "Qvn2DeliveryNotify",            limit: 1,                            null: false
    t.char    "Qvn2ExceptionNotify",           limit: 1,                            null: false
    t.string  "Qvn2ContactName",               limit: 35,                           null: false
    t.string  "Qvn2Email",                     limit: 100,                          null: false
    t.char    "Qvn3ShipNotify",                limit: 1,                            null: false
    t.char    "Qvn3DeliveryNotify",            limit: 1,                            null: false
    t.char    "Qvn3ExceptionNotify",           limit: 1,                            null: false
    t.string  "Qvn3ContactName",               limit: 35,                           null: false
    t.string  "Qvn3Email",                     limit: 100,                          null: false
    t.string  "CustomsDescriptionOfGoods",     limit: 150
    t.char    "CustomsDocumentsOnly",          limit: 1
    t.varchar "ShipperNumber",                 limit: 10,                           null: false
    t.integer "PackageCount",                                                       null: false
    t.char    "DeliveryConfirmation",          limit: 1,                            null: false
    t.char    "DeliveryConfirmationAdult",     limit: 1,                            null: false
    t.varchar "InvoiceTermsOfSale",            limit: 3
    t.varchar "InvoiceReasonForExport",        limit: 2
    t.string  "InvoiceComments",               limit: 200
    t.varchar "InvoiceCurrencyCode",           limit: 3
    t.money   "InvoiceChargesFreight",                     precision: 19, scale: 4
    t.money   "InvoiceChargesInsurance",                   precision: 19, scale: 4
    t.money   "InvoiceChargesOther",                       precision: 19, scale: 4
    t.bigint  "ShipmentProcessedOnComputerID"
    t.string  "UspsEndorsement",               limit: 50
    t.char    "CarbonNeutral",                 limit: 10
  end

  create_table "YahooOrder", primary_key: "OrderID", id: :bigint, force: :cascade do |t|
    t.varchar "YahooOrderID", limit: 50, null: false
  end

  create_table "YahooOrderItem", primary_key: "OrderItemID", id: :bigint, force: :cascade do |t|
    t.string "YahooProductID", limit: 255,              null: false
    t.string "Url",            limit: 255, default: "", null: false
  end

  create_table "YahooProduct", primary_key: ["StoreID", "YahooProductID"], force: :cascade do |t|
    t.bigint "StoreID",                    null: false
    t.string "YahooProductID", limit: 255, null: false
    t.float  "Weight",                     null: false
  end

  create_table "YahooStore", primary_key: "StoreID", id: :bigint, force: :cascade do |t|
    t.bigint  "YahooEmailAccountID",                             null: false
    t.varchar "TrackingUpdatePassword", limit: 100,              null: false
    t.varchar "YahooStoreID",           limit: 50,  default: "", null: false
    t.varchar "AccessToken",            limit: 200, default: "", null: false
    t.bigint  "BackupOrderNumber"
  end

  create_table "iParcelAccount", primary_key: "iParcelAccountID", id: :bigint, force: :cascade do |t|
    t.ss_timestamp "RowVersion",                null: false
    t.string       "Username",      limit: 50,  null: false
    t.string       "Password",      limit: 50,  null: false
    t.string       "Description",   limit: 50,  null: false
    t.string       "FirstName",     limit: 30,  null: false
    t.string       "MiddleName",    limit: 30,  null: false
    t.string       "LastName",      limit: 30,  null: false
    t.string       "Company",       limit: 30,  null: false
    t.string       "Street1",       limit: 50,  null: false
    t.string       "Street2",       limit: 50,  null: false
    t.string       "City",          limit: 30,  null: false
    t.string       "StateProvCode", limit: 30,  null: false
    t.string       "PostalCode",    limit: 20,  null: false
    t.string       "CountryCode",   limit: 50,  null: false
    t.string       "Phone",         limit: 25,  null: false
    t.string       "Email",         limit: 100, null: false
    t.string       "Website",       limit: 50,  null: false
  end

  create_table "iParcelPackage", primary_key: "iParcelPackageID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShipmentID",                                             null: false
    t.float   "Weight",                                                 null: false
    t.bigint  "DimsProfileID",                                          null: false
    t.float   "DimsLength",                                             null: false
    t.float   "DimsWidth",                                              null: false
    t.float   "DimsHeight",                                             null: false
    t.boolean "DimsAddWeight",                                          null: false
    t.float   "DimsWeight",                                             null: false
    t.boolean "Insurance",                                              null: false
    t.money   "InsuranceValue",                precision: 19, scale: 4, null: false
    t.boolean "InsurancePennyOne",                                      null: false
    t.money   "DeclaredValue",                 precision: 19, scale: 4, null: false
    t.varchar "TrackingNumber",    limit: 50,                           null: false
    t.string  "ParcelNumber",      limit: 50,                           null: false
    t.string  "SkuAndQuantities",  limit: 500,                          null: false
    t.index ["ShipmentID"], name: "IX_iParcelPackage_ShipmentID"
  end

  create_table "iParcelProfile", primary_key: "ShippingProfileID", id: :bigint, force: :cascade do |t|
    t.bigint  "iParcelAccountID"
    t.integer "Service"
    t.string  "Reference",          limit: 300
    t.boolean "TrackByEmail"
    t.boolean "TrackBySMS"
    t.boolean "IsDeliveryDutyPaid"
    t.string  "SkuAndQuantities",   limit: 500
  end

  create_table "iParcelProfilePackage", primary_key: "iParcelProfilePackageID", id: :bigint, force: :cascade do |t|
    t.bigint  "ShippingProfileID", null: false
    t.float   "Weight"
    t.bigint  "DimsProfileID"
    t.float   "DimsLength"
    t.float   "DimsWidth"
    t.float   "DimsHeight"
    t.float   "DimsWeight"
    t.boolean "DimsAddWeight"
  end

  create_table "iParcelShipment", primary_key: "ShipmentID", id: :bigint, force: :cascade do |t|
    t.bigint  "iParcelAccountID",                 null: false
    t.integer "Service",                          null: false
    t.string  "Reference",            limit: 300, null: false
    t.boolean "TrackByEmail",                     null: false
    t.boolean "TrackBySMS",                       null: false
    t.boolean "IsDeliveryDutyPaid",               null: false
    t.integer "RequestedLabelFormat",             null: false
    t.index ["Service"], name: "IX_IParcelShipment_Service"
  end

  add_foreign_key "ActionFilterTrigger", "Action", column: "ActionID", primary_key: "ActionID", name: "FK_ActionFilterTrigger_Action"
  add_foreign_key "ActionQueue", "Action", column: "ActionID", primary_key: "ActionID", name: "FK_ActionQueue_Action", on_delete: :cascade
  add_foreign_key "ActionQueue", "Computer", column: "TriggerComputerID", primary_key: "ComputerID", name: "FK_ActionQueue_Computer"
  add_foreign_key "ActionQueueSelection", "ActionQueue", column: "ActionQueueID", primary_key: "ActionQueueID", name: "FK_ActionQueueSelection_ActionQueue", on_delete: :cascade
  add_foreign_key "ActionQueueStep", "ActionQueue", column: "ActionQueueID", primary_key: "ActionQueueID", name: "FK_ActionQueueStep_ActionQueue", on_delete: :cascade
  add_foreign_key "ActionTask", "Action", column: "ActionID", primary_key: "ActionID", name: "FK_ActionTask_Action"
  add_foreign_key "AmazonASIN", "AmazonStore", column: "StoreID", primary_key: "StoreID", name: "FK_AmazonASIN_AmazonStore", on_delete: :cascade
  add_foreign_key "AmazonOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_AmazonOrder_Order"
  add_foreign_key "AmazonOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_AmazonOrderItem_OrderItem"
  add_foreign_key "AmazonProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_AmazonProfile_ShippingProfile", on_delete: :cascade
  add_foreign_key "AmazonShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_AmazonShipment_Shipment", on_delete: :cascade
  add_foreign_key "AmazonStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_AmazonStore_Store"
  add_foreign_key "AmeriCommerceStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_AmeriCommerceStore_Store"
  add_foreign_key "Audit", "Computer", column: "ComputerID", primary_key: "ComputerID", name: "FK_Audit_Computer"
  add_foreign_key "Audit", "User", column: "UserID", primary_key: "UserID", name: "FK_Audit_User"
  add_foreign_key "AuditChange", "Audit", column: "AuditID", primary_key: "AuditID", name: "FK_AuditChange_Audit"
  add_foreign_key "AuditChangeDetail", "AuditChange", column: "AuditChangeID", primary_key: "AuditChangeID", name: "FK_AuditChangeDetail_AuditChange", on_delete: :cascade
  add_foreign_key "BestRateProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_BestRateProfile_ShippingProfile", on_delete: :cascade
  add_foreign_key "BestRateShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_BestRateShipment_Shipment", on_delete: :cascade
  add_foreign_key "BigCommerceOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_BigCommerceOrderItem_OrderItem"
  add_foreign_key "BigCommerceStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_BigCommerceStore_Store"
  add_foreign_key "BuyDotComOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_BuyDotComOrderItem_OrderItem"
  add_foreign_key "BuyDotComStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_BuyComStore_Store"
  add_foreign_key "ChannelAdvisorOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_ChannelAdvisorOrder_Order"
  add_foreign_key "ChannelAdvisorOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_ChannelAdvisorOrderItem_OrderItem"
  add_foreign_key "ChannelAdvisorStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_ChannelAdvisorStore_Store"
  add_foreign_key "ClickCartProOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_ClickCartProOrder_Order"
  add_foreign_key "CommerceInterfaceOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_CommerceInterfaceOrder_Order"
  add_foreign_key "Download", "Computer", column: "ComputerID", primary_key: "ComputerID", name: "FK_Download_Computer"
  add_foreign_key "Download", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_Download_Store", on_delete: :cascade
  add_foreign_key "Download", "User", column: "UserID", primary_key: "UserID", name: "FK_Download_User"
  add_foreign_key "DownloadDetail", "Download", column: "DownloadID", primary_key: "DownloadID", name: "FK_DownloadDetail_Download", on_delete: :cascade
  add_foreign_key "EbayCombinedOrderRelation", "EbayOrder", column: "OrderID", primary_key: "OrderID", name: "FK_EbayCombinedOrderRelation_EbayOrder", on_delete: :cascade
  add_foreign_key "EbayCombinedOrderRelation", "EbayStore", column: "StoreID", primary_key: "StoreID", name: "FK_EbayCombinedOrderRelation_EbayStore", on_delete: :cascade
  add_foreign_key "EbayOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_EbayOrder_Order"
  add_foreign_key "EbayOrderItem", "EbayOrder", column: "OrderID", primary_key: "OrderID", name: "FK_EbayOrderItem_EbayOrder"
  add_foreign_key "EbayOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_EbayOrderItem_OrderItem"
  add_foreign_key "EbayStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_EbayStore_Store"
  add_foreign_key "EmailOutboundRelation", "EmailOutbound", column: "EmailOutboundID", primary_key: "EmailOutboundID", name: "FK_EmailOutboundObject_EmailOutbound", on_delete: :cascade
  add_foreign_key "EndiciaProfile", "PostalProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_EndiciaProfile_PostalProfile", on_delete: :cascade
  add_foreign_key "EndiciaScanForm", "ScanFormBatch", column: "ScanFormBatchID", primary_key: "ScanFormBatchID", name: "FK_EndiciaScanForm_EndiciaScanForm"
  add_foreign_key "EndiciaShipment", "PostalShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_EndiciaShipment_PostalShipment", on_delete: :cascade
  add_foreign_key "EndiciaShipment", "ScanFormBatch", column: "ScanFormBatchID", primary_key: "ScanFormBatchID", name: "FK_EndiciaShipment_ScanFormBatch"
  add_foreign_key "EtsyOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_EtsyOrder_Order"
  add_foreign_key "EtsyStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_EtsyStore_Store"
  add_foreign_key "FedExPackage", "FedExShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_FedExPackage_FedExShipment", on_delete: :cascade
  add_foreign_key "FedExProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_FedExProfile_ShippingProfile", on_delete: :cascade
  add_foreign_key "FedExProfilePackage", "FedExProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_FedExProfilePackage_FedExProfile", on_delete: :cascade
  add_foreign_key "FedExShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_FedExShipment_Shipment", on_delete: :cascade
  add_foreign_key "FilterLayout", "FilterNode", column: "FilterNodeID", primary_key: "FilterNodeID", name: "FK_FilterLayout_FilterNode"
  add_foreign_key "FilterLayout", "User", column: "UserID", primary_key: "UserID", name: "FK_FilterLayout_User"
  add_foreign_key "FilterNode", "FilterNode", column: "ParentFilterNodeID", primary_key: "FilterNodeID", name: "FK_FilterNode_Parent"
  add_foreign_key "FilterNode", "FilterNodeContent", column: "FilterNodeContentID", primary_key: "FilterNodeContentID", name: "FK_FilterNode_FilterNodeContent"
  add_foreign_key "FilterNode", "FilterSequence", column: "FilterSequenceID", primary_key: "FilterSequenceID", name: "FK_FilterNode_FilterSequence"
  add_foreign_key "FilterNodeColumnSettings", "FilterNode", column: "FilterNodeID", primary_key: "FilterNodeID", name: "FK_FilterNodeColumnSettings_FilterNode", on_delete: :cascade
  add_foreign_key "FilterNodeColumnSettings", "GridColumnLayout", column: "GridColumnLayoutID", primary_key: "GridColumnLayoutID", name: "FK_FilterNodeColumnSettings_GridColumnLayout"
  add_foreign_key "FilterNodeColumnSettings", "User", column: "UserID", primary_key: "UserID", name: "FK_FilterNodeColumnSettings_User"
  add_foreign_key "FilterNodeContentDetail", "FilterNodeContent", column: "FilterNodeContentID", primary_key: "FilterNodeContentID", name: "FK_FilterNodeContentDetail_FilterNodeContent", on_delete: :cascade
  add_foreign_key "FilterSequence", "Filter", column: "FilterID", primary_key: "FilterID", name: "FK_FilterSequence_Filter"
  add_foreign_key "FilterSequence", "Filter", column: "ParentFilterID", primary_key: "FilterID", name: "FK_FilterSequence_Folder"
  add_foreign_key "GenericFileStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_GenericFileStore_Store"
  add_foreign_key "GenericModuleStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_GenericModuleStore_Store"
  add_foreign_key "GridColumnFormat", "User", column: "UserID", primary_key: "UserID", name: "FK_GridColumnFormat_User"
  add_foreign_key "GridColumnPosition", "GridColumnLayout", column: "GridColumnLayoutID", primary_key: "GridColumnLayoutID", name: "FK_GridLayoutColumn_GridLayout", on_delete: :cascade
  add_foreign_key "GrouponOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_GrouponOrder_Order"
  add_foreign_key "GrouponOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_GrouponOrderItem_OrderItem"
  add_foreign_key "GrouponStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_GrouponStore_Store"
  add_foreign_key "InfopiaOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_InfopiaOrderItem_OrderItem"
  add_foreign_key "InfopiaStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_InfopiaStore_InfopiaStore"
  add_foreign_key "InsurancePolicy", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_InsurancePolicy_Shipment", on_delete: :cascade
  add_foreign_key "LemonStandOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_LemonStandOrder_Order"
  add_foreign_key "LemonStandOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_LemonStandOrderItem_OrderItem"
  add_foreign_key "LemonStandStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_LemonStandStore_Store"
  add_foreign_key "MagentoOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_MagentoOrder_Order"
  add_foreign_key "MagentoStore", "GenericModuleStore", column: "StoreID", primary_key: "StoreID", name: "FK_MagentoStore_GenericModuleStore"
  add_foreign_key "MarketplaceAdvisorOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_MarketworksOrder_Order"
  add_foreign_key "MarketplaceAdvisorStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_MarketworksStore_Store"
  add_foreign_key "MivaOrderItemAttribute", "OrderItemAttribute", column: "OrderItemAttributeID", primary_key: "OrderItemAttributeID", name: "FK_MivaOrderItemAttribute_OrderItemAttribute"
  add_foreign_key "MivaStore", "GenericModuleStore", column: "StoreID", primary_key: "StoreID", name: "FK_MivaStore_GenericModuleStore"
  add_foreign_key "NetworkSolutionsOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_NetworkSolutionsOrder_Order"
  add_foreign_key "NetworkSolutionsStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_NetworkSolutionsStore_Store"
  add_foreign_key "NeweggOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_NeweggOrder_Order"
  add_foreign_key "NeweggOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_NeweggOrderItem_OrderItem"
  add_foreign_key "NeweggStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_NeweggStore_Store"
  add_foreign_key "Note", "User", column: "UserID", primary_key: "UserID", name: "FK_Note_User"
  add_foreign_key "OdbcStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_OdbcStore_Store"
  add_foreign_key "OnTracProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_OnTracProfile_ShippingProfile"
  add_foreign_key "OnTracShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_OnTracShipment_Shipment", on_delete: :cascade
  add_foreign_key "Order", "Customer", column: "CustomerID", primary_key: "CustomerID", name: "FK_Order_Customer"
  add_foreign_key "Order", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_Order_Store"
  add_foreign_key "OrderCharge", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_OrderCharge_Order"
  add_foreign_key "OrderItem", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_OrderItem_Order"
  add_foreign_key "OrderItemAttribute", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_OrderItemAttribute_OrderItem"
  add_foreign_key "OrderMotionOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_OrderMotionOrder_Order"
  add_foreign_key "OrderMotionStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_OrderMotionStore_Store"
  add_foreign_key "OrderPaymentDetail", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_OrderPaymentDetail_Order"
  add_foreign_key "OtherProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_OtherProfile_ShippingProfile", on_delete: :cascade
  add_foreign_key "OtherShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_OtherShipment_Shipment", on_delete: :cascade
  add_foreign_key "PayPalOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_PayPalOrder_Order"
  add_foreign_key "PayPalStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_PayPalStore_Store"
  add_foreign_key "Permission", "User", column: "UserID", primary_key: "UserID", name: "FK_Permission_User"
  add_foreign_key "PostalProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_PostalProfile_ShippingProfile", on_delete: :cascade
  add_foreign_key "PostalShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_PostalShipment_Shipment", on_delete: :cascade
  add_foreign_key "PrintResult", "Computer", column: "ComputerID", primary_key: "ComputerID", name: "FK_PrintResult_Computer"
  add_foreign_key "ProStoresOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_ProStoresOrder_Order"
  add_foreign_key "ProStoresStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_ProStoresStore_Store"
  add_foreign_key "Scheduling_CRON_TRIGGERS", "Scheduling_TRIGGERS", column: "SCHED_NAME", primary_key: "SCHED_NAME", name: "FK_Scheduling_CRON_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_CRON_TRIGGERS", "Scheduling_TRIGGERS", column: "TRIGGER_GROUP", primary_key: "TRIGGER_GROUP", name: "FK_Scheduling_CRON_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_CRON_TRIGGERS", "Scheduling_TRIGGERS", column: "TRIGGER_NAME", primary_key: "TRIGGER_NAME", name: "FK_Scheduling_CRON_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_SIMPLE_TRIGGERS", "Scheduling_TRIGGERS", column: "SCHED_NAME", primary_key: "SCHED_NAME", name: "FK_Scheduling_SIMPLE_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_SIMPLE_TRIGGERS", "Scheduling_TRIGGERS", column: "TRIGGER_GROUP", primary_key: "TRIGGER_GROUP", name: "FK_Scheduling_SIMPLE_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_SIMPLE_TRIGGERS", "Scheduling_TRIGGERS", column: "TRIGGER_NAME", primary_key: "TRIGGER_NAME", name: "FK_Scheduling_SIMPLE_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_SIMPROP_TRIGGERS", "Scheduling_TRIGGERS", column: "SCHED_NAME", primary_key: "SCHED_NAME", name: "FK_Scheduling_SIMPROP_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_SIMPROP_TRIGGERS", "Scheduling_TRIGGERS", column: "TRIGGER_GROUP", primary_key: "TRIGGER_GROUP", name: "FK_Scheduling_SIMPROP_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_SIMPROP_TRIGGERS", "Scheduling_TRIGGERS", column: "TRIGGER_NAME", primary_key: "TRIGGER_NAME", name: "FK_Scheduling_SIMPROP_TRIGGERS_Scheduling_TRIGGERS", on_delete: :cascade
  add_foreign_key "Scheduling_TRIGGERS", "Scheduling_JOB_DETAILS", column: "JOB_GROUP", primary_key: "JOB_GROUP", name: "FK_Scheduling_TRIGGERS_Scheduling_JOB_DETAILS"
  add_foreign_key "Scheduling_TRIGGERS", "Scheduling_JOB_DETAILS", column: "JOB_NAME", primary_key: "JOB_NAME", name: "FK_Scheduling_TRIGGERS_Scheduling_JOB_DETAILS"
  add_foreign_key "Scheduling_TRIGGERS", "Scheduling_JOB_DETAILS", column: "SCHED_NAME", primary_key: "SCHED_NAME", name: "FK_Scheduling_TRIGGERS_Scheduling_JOB_DETAILS"
  add_foreign_key "SearsOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_SearsOrder_Order"
  add_foreign_key "SearsOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_SearsOrderItem_OrderItem"
  add_foreign_key "SearsStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_SearsStore_Store"
  add_foreign_key "ServerMessageSignoff", "Computer", column: "ComputerID", primary_key: "ComputerID", name: "FK_ServerMessageSignoff_Computer", on_delete: :cascade
  add_foreign_key "ServerMessageSignoff", "ServerMessage", column: "ServerMessageID", primary_key: "ServerMessageID", name: "FK_ServerMessageSignoff_DashboardMessage"
  add_foreign_key "ServiceStatus", "Computer", column: "ComputerID", primary_key: "ComputerID", name: "FK_ServiceStatus_Computer"
  add_foreign_key "Shipment", "Computer", column: "ProcessedComputerID", primary_key: "ComputerID", name: "FK_Shipment_ProcessedComputer"
  add_foreign_key "Shipment", "Computer", column: "VoidedComputerID", primary_key: "ComputerID", name: "FK_Shipment_VoidedComputer"
  add_foreign_key "Shipment", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_Shipment_Order"
  add_foreign_key "Shipment", "User", column: "ProcessedUserID", primary_key: "UserID", name: "FK_Shipment_ProcessedUser"
  add_foreign_key "Shipment", "User", column: "VoidedUserID", primary_key: "UserID", name: "FK_Shipment_VoidedUser"
  add_foreign_key "ShipmentCustomsItem", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_ShipmentCustomsItem_Shipment", on_delete: :cascade
  add_foreign_key "ShippingPrintOutputRule", "ShippingPrintOutput", column: "ShippingPrintOutputID", primary_key: "ShippingPrintOutputID", name: "FK_ShippingPrintOutputRule_ShippingPrintOutput", on_delete: :cascade
  add_foreign_key "ShopSiteStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_StoreShopSite_Store"
  add_foreign_key "ShopifyOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_ShopifyOrder_Order"
  add_foreign_key "ShopifyOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_ShopifyOrderItem_OrderItem"
  add_foreign_key "ShopifyStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_ShopifyStore_Store"
  add_foreign_key "SparkPayStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_SparkPayStore_Store"
  add_foreign_key "StatusPreset", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_StatusPreset_Store", on_delete: :cascade
  add_foreign_key "Template", "TemplateFolder", column: "ParentFolderID", primary_key: "TemplateFolderID", name: "FK_Template_TemplateFolder"
  add_foreign_key "TemplateComputerSettings", "Computer", column: "ComputerID", primary_key: "ComputerID", name: "FK_TemplateComputerSettings_Computer", on_delete: :cascade
  add_foreign_key "TemplateComputerSettings", "Template", column: "TemplateID", primary_key: "TemplateID", name: "FK_TemplateComputerSettings_Template", on_delete: :cascade
  add_foreign_key "TemplateFolder", "TemplateFolder", column: "ParentFolderID", primary_key: "TemplateFolderID", name: "FK_TemplateFolder_TemplateFolder"
  add_foreign_key "TemplateStoreSettings", "Template", column: "TemplateID", primary_key: "TemplateID", name: "FK_TemplateStoreSettings_Template", on_delete: :cascade
  add_foreign_key "TemplateUserSettings", "Template", column: "TemplateID", primary_key: "TemplateID", name: "FK_TemplateUserSettings_Template", on_delete: :cascade
  add_foreign_key "TemplateUserSettings", "User", column: "UserID", primary_key: "UserID", name: "FK_TemplateUserSettings_User", on_delete: :cascade
  add_foreign_key "ThreeDCartOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_ThreeDCartOrder_Order"
  add_foreign_key "ThreeDCartOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_ThreeDCartOrderItem_OrderItem"
  add_foreign_key "ThreeDCartStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_ThreeDCartStore_Store"
  add_foreign_key "UpsPackage", "UpsShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_UpsPackage_UpsShipment", on_delete: :cascade
  add_foreign_key "UpsProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_UpsProfile_ShippingProfile", on_delete: :cascade
  add_foreign_key "UpsProfilePackage", "UpsProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_UpsProfilePackage_UpsProfile", on_delete: :cascade
  add_foreign_key "UpsShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_UpsShipment_Shipment", on_delete: :cascade
  add_foreign_key "UserColumnSettings", "GridColumnLayout", column: "GridColumnLayoutID", primary_key: "GridColumnLayoutID", name: "FK_UserColumnSettings_GridColumnLayout"
  add_foreign_key "UserColumnSettings", "User", column: "UserID", primary_key: "UserID", name: "FK_UserColumnSettings_User"
  add_foreign_key "UserSettings", "User", column: "UserID", primary_key: "UserID", name: "FK_UserSetting_User"
  add_foreign_key "UspsProfile", "PostalProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_UspsProfile_PostalProfile", on_delete: :cascade
  add_foreign_key "UspsScanForm", "ScanFormBatch", column: "ScanFormBatchID", primary_key: "ScanFormBatchID", name: "FK_UspsScanForm_ScanFormBatch"
  add_foreign_key "UspsShipment", "PostalShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_UspsShipment_PostalShipment", on_delete: :cascade
  add_foreign_key "UspsShipment", "ScanFormBatch", column: "ScanFormBatchID", primary_key: "ScanFormBatchID", name: "FK_UspsShipment_ScanFormBatch"
  add_foreign_key "VersionSignoff", "Computer", column: "ComputerID", primary_key: "ComputerID", name: "FK_VersionVerification_Computer", on_delete: :cascade
  add_foreign_key "VolusionStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_VolusionStore_Store"
  add_foreign_key "WalmartOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_WalmartOrder_Order"
  add_foreign_key "WalmartOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_WalmartOrderItem_OrderItem"
  add_foreign_key "WalmartStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_WalmartStore_Store"
  add_foreign_key "WorldShipGoods", "WorldShipShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_WorldShipGoods_WorldShipShipment", on_delete: :cascade
  add_foreign_key "WorldShipPackage", "WorldShipShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_WorldShipPackage_WorldShipShipment", on_delete: :cascade
  add_foreign_key "WorldShipShipment", "UpsShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_WorldShipShipment_UpsShipment", on_delete: :cascade
  add_foreign_key "YahooOrder", "Order", column: "OrderID", primary_key: "OrderID", name: "FK_YahooOrder_Order"
  add_foreign_key "YahooOrderItem", "OrderItem", column: "OrderItemID", primary_key: "OrderItemID", name: "FK_YahooOrderItem_OrderItem"
  add_foreign_key "YahooProduct", "YahooStore", column: "StoreID", primary_key: "StoreID", name: "FK_YahooProduct_YahooStore", on_delete: :cascade
  add_foreign_key "YahooStore", "Store", column: "StoreID", primary_key: "StoreID", name: "FK_YahooStore_Store"
  add_foreign_key "iParcelPackage", "iParcelShipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_iParcelPackage_iParcelShipment", on_delete: :cascade
  add_foreign_key "iParcelProfile", "ShippingProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_iParcelProfile_ShippingProfile", on_delete: :cascade
  add_foreign_key "iParcelProfilePackage", "iParcelProfile", column: "ShippingProfileID", primary_key: "ShippingProfileID", name: "FK_iParcelPackageProfile_iParcelProfile", on_delete: :cascade
  add_foreign_key "iParcelShipment", "Shipment", column: "ShipmentID", primary_key: "ShipmentID", name: "FK_iParcelShipment_Shipment", on_delete: :cascade
end
