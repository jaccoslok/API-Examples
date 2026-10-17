# API Examples for Business Central

A sample Business Central AL extension demonstrating custom API pages for BCPortal.Cloud.

**Important:** Before using this extension, generate a **new** GUID for the application ID and provide your own application and publisher names in `app.json`.

## Overview

This extension demonstrates how to expose Business Central data through custom REST API pages for use with BCPortal.Cloud.

## Features

- **Items API**: Exposes item data through a custom API endpoint
  - Endpoint: `/api/slokSoftware/bcPortal/v2.0/items`
  - Read-only access to item information including:
    - Item number
    - Description
    - Country/region of origin
    - Unit price
    - Inventory levels
    - Sales unit of measure

  - **Sales Orders API**: Exposes sales order data through a custom API endpoint
  - Endpoint: `/api/slokSoftware/bcPortal/v2.0/salesOrders`
  - This example includes a custom text field "My Custom Field"
  - Supports create, read, update, and delete operations
  - Includes customer details, billing and shipping addresses
  - Order status, delivery dates, and financial totals
  - Enables integration of custom fields with BCPortal.Cloud

- **Blanket Sales Orders API**: Exposes blanket sales orders and their lines
  - Endpoint: `/api/slokSoftware/bcPortal/v2.0/blanketSalesOrders`
  - Includes sell-to, bill-to, and ship-to contact and address details
  - Includes blanket order lines, unit-of-measure data, and ordered, shipped, invoiced, outstanding, and remaining quantities in document and base units
  - Allows updates to the line's quantity to ship, including its base quantity; other line fields are read-only
  - Provides a `CreateSalesOrder` action to convert a blanket order into a sales order
  - **Available only on request** because blanket order support requires additional implementation and support from Slok Software and your Business Central partner

## Requirements

- Business Central version 27.0 or higher
- Runtime 16.0 or higher

## Installation

This example application is not intended for production use. Work with your Business Central partner to implement the customizations you need. Slok Software does not provide general Business Central customization services; arrange those services through your partner.

1. Confirm with your Business Central partner that the object ID range used by this app does not conflict with other customizations.
2. Generate a new GUID for the `id` property in `app.json`.
3. Build your `.app` file in VS Code
4. Install the extension in your Business Central environment through Extension Management or the Business Central admin center.
5. The API endpoints will then be available automatically.

## API Usage

### Items Endpoint

**GET** `/api/slokSoftware/BcPortal/v2.0/items`

Returns a list of items with the following fields:
- `id`: System ID (GUID)
- `number`: Item number
- `description`: Item description
- `countryRegionOfOriginCode`: Country/Region of origin
- `unitPrice`: Unit price
- `inventory`: Current inventory level
- `salesUnitOfMeasure`: Sales unit of measure

### Example Request

```http
GET https://your-bc-instance.com/api/slokSoftware/BcPortal/v2.0/items
Authorization: Bearer {your-token}
```

### Example Response

```json
{
  "value": [
    {
      "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "number": "1000",
      "description": "Sample Item",
      "countryRegionOfOriginCode": "US",
      "unitPrice": 10.50,
      "inventory": 100,
      "salesUnitOfMeasure": "PCS"
    }
  ]
}
```

### Blanket Sales Orders Endpoint

**GET** `/api/slokSoftware/BcPortal/v2.0/blanketSalesOrders`

Returns blanket sales orders with customer and shipping addresses, currency, totals, and status. Each order includes the `blanketSalesOrderLines` navigation property.

Blanket order lines expose the unit of measure and conversion factor, quantities in document and base units, remaining and outstanding quantities, shipped and invoiced quantities, and quantities to ship or invoice. The `shipQuantity` and `shipQuantityBase` fields are editable; all other line fields are read-only. Line creation is disabled.

The bound `CreateSalesOrder` action converts the selected blanket sales order using Business Central's standard conversion codeunit. Blanket order API support is available only on request and requires additional implementation and support from Slok Software and your Business Central partner.

### Example Request

```http
GET https://your-bc-instance.com/api/slokSoftware/BcPortal/v2.0/blanketSalesOrders
Authorization: Bearer {your-token}
```

## Development

### Project Structure

```
.
├── app.json                         # Extension manifest
├── src/
│   ├── API/
│   │   ├── ItemsAPI.Page.al                   # Items API page
│   │   ├── BlanketSalesOrdersAPI.Page.al      # Blanket Sales Orders API page
│   │   ├── BlanketSalesOrderLinesAPI.Page.al  # Blanket Sales Order Lines API page
│   │   └── SalesOrdersAPI.Page.al             # Sales Orders API page
│   └── Sales/
│       └── Documents/
│           ├── SalesHeader.TableExt.al              # Sales Header table extension
│           ├── SalesOrder.PageExt.al                # Sales Order page extension
│           └── SalesOrderEntityBuffer.TableExt.al   # Sales Order Entity Buffer table extension
└── README.md                        # This file
```

### Building the Extension

1. Open the workspace in Visual Studio Code with AL Language extension
2. Press `Ctrl+Shift+B` (or `Cmd+Shift+B` on Mac) to build
3. The `.app` file will be generated

## Support

For support and more information, visit [BCPortal.Cloud](https://www.slok.com/bcportal)

## License

© Slok Software

## Version History

### 1.0.0.0
- Initial release
- Items API endpoint
