{% docs %}
  
One of the following values:

| COLUMN NAME                  | DESCRIPTION                                                       |
|------------------------------|-------------------------------------------------------------------|
| ADDRESS_ID                   | Unique identifier for each address record.                         |
| ZIPCODE                      | Postal code associated with the address.                           |
| COUNTRY                      | Country of the address.                                           |
| ADDRESS                      | Full address including street name and number.                     |
| STATE                        | State of the address.                                             |
| _FIVETRAN_DELETED            | Indicator if the record has been marked as deleted by Fivetran.   |
| _FIVETRAN_SYNCED_UTC         | The timestamp when Fivetran synchronized the data in UTC time zone.|
| EVENT_ID                     | Unique identifier for each event.                                 |
| PAGE_URL                     | URL of the page where the event occurred.                         |
| EVENT_TYPE                   | Type of the event name (e.g., checkout, view).                   |
| USER_ID                      | Identifier of the user who triggered the event.                   |
| PRODUCT_ID                   | Identifier of the product related to the event.                   |
| SESSION_ID                   | Identifier of the session in which the event occurred.            |
| CREATED_AT                   | Timestamp when the event was created.                             |
| ORDER_ID                     | Unique identifier for each order.                                 |
| SHIPPING_SERVICE_NAME        | Name of the shipping service used for the order.                  |
| SHIPPING_COST_AMOUNT_EURO    | Cost of shipping the order in Euro.                               |
| PROMO_ID                     | Identifier of the promotion applied to the order.                 |
| ESTIMATED_DELIVERY_AT        | Estimated delivery time of the order.                             |
| ORDER_COST_EURO              | Cost of the order before shipping and promotions.                 |
| ORDER_TOTAL_EURO             | Total cost of the order after shipping and promotions.            |
| DELIVERED_AT                 | Timestamp when the order was delivered.                           |
| TRACKING_ID                  | Tracking identifier for the order shipment.                       |
| STATUS_ID                    | Identifier of the status.                                         |
| STATUS_NAME                  | Name of the status.                                               |
| PROMO_NAME                   | Promo name.                                                       |
| DISCOUNT_EURO                | Amount of discount provided by the promotion.                     |
| STATUS_NAME                  | Status of the promotion (e.g., active, inactive).                 |
| UPDATED_AT                   | Timestamp of the last update.                                     |
| LAST_NAME                    | Last name of the user.                                            |
| PHONE_NUMBER                 | Phone number of the user.                                         |
| IS_VALID_PHONE_NUMBER        | Check if the phone number is correct.                             |
| TOTAL_ORDERS                 | Total number of orders placed by the user.                        |
| FIRST_NAME                   | First name of the user.                                           |
| EMAIL                        | Email address of the user.                                        |
| IS_VALID_EMAIL_ADDRESS       | Check if the email is correct.                                    |
| PRODUCT_ID                   | Unique product identifier.                                        |
| PRICE_EURO                   | Price of the product in euro.                                     |
| PRODUCT_NAME                 | Product name.                                                     |
| INVENTORY                    | Amount of inventory available.                                    |
| _ROW                         | The row number from the Google Sheets document.                   |
| QUANTITY                     | The quantity of the product reported in the respective month.     |
| MONTH                        | The month for which the budget data is reported.                  |
| DATE_LOAD                    | The timestamp when the data was loaded into the staging table.    |
| DATE                         | Specific date.                                                    |
| YEAR                         | The year.                                                         |
| MONTH_NAME                   | The name of the month.                                            |
| DAY                          | The day of the month.                                             |
| NUMBER_WEEK_DAY              | The numeric representation of the day of the week.                |
| WEEK_DAY                     | The name of the day of the week.                                  |
| QUARTER                      | The quarter of the year.                                          |

{% enddocs %}
