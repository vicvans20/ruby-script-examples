# Ruby - Cybersource SOAP API with savon
require 'savon'

MERCHAND_ID = "xxxx"
TRANSACTION_KEY = "yyy"

DEV_CLIENT = Savon.client(
  log: true, log_level: :debug, pretty_print_xml: true, 
  convert_request_keys_to: :none, 
  wsdl: "https://ics2wstest.ic3.com/commerce/1.x/transactionProcessor/CyberSourceTransaction_1.181.wsdl", 
  wsse_auth: [MERCHANT_ID, TRANSACTION_KEY],
  env_namespace: 'soapenv',
  namespace: "urn:schemas-cybersource-com:transaction-data-1.181"
)

def example_payment_auth
  data = {
    merchantID: MERCHANT_ID,
    merchantReferenceCode: rand(100),
    billTo: {
      firstName: "Foo",
      lastName: "Bar",
    },
    purchaseTotals: {
      currency: "USD",
      grandTotalAmount: 5,
    },
    card: {
      accountNumber: "4111111111111111",
      expirationMonth: "12",
      expirationYear: "2020"
    },
    ccAuthService: { :@run => "true" }, # IMPORTANT this must be positioned at the bottom else a XML parse error is raised
  }
end