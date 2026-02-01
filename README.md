# API Examples for Business Central

A Business Central AL example extension that provides guidance on implementing custom API pages for use with BCPortal.Cloud.

**Important:** If you wish to use this extension, please ensure that you generate a **new** GUID for the App ID and provide your own App and Publisher name in the app.json file.

## Overview

This extension demonstrates how to create custom API pages for BCPortal.Cloud in Business Central. It includes examples of exposing data through REST APIs that can be consumed by our portal solution.

## Features

- **Items API**: Exposes Item data through a custom API endpoint
  - Endpoint: `/api/slokSoftware/bcPortal/v2.0/items`
  - Read-only access to item information including:
    - Item number
    - Description
    - Country/Region of Origin
    - Unit Price
    - Inventory levels
    - Sales Unit of Measure

- **Sales Orders API**: Exposes Sales Order data through a custom API endpoint
  - Endpoint: `/api/slokSoftware/bcPortal/v2.0/salesOrders`
  - This example includes a custom text field "My Custom Field"
  - Full CRUD operations for sales order management
  - Includes customer details, billing and shipping addresses
  - Order status, delivery dates, and financial totals
  - Enables integration of custom fields with BCPortal.Cloud

## Requirements

- Business Central version 27.0 or higher
- Runtime 16.0

## Installation

This is **an example application** and is not intended for production environments. We strongly recommend working with your Business Central partner to implement the desired customizations. Please note that we do not provide customization services.

1. Check the no. series used in this app with your Business Central partner so this app cannot collide with other customizations
2. Build your `.app` file in VS Code
3. Install the extension in your Business Central environment using the Extension Management page
4. The API endpoints will be automatically available

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

## Development

### Project Structure

```
.
├── app.json                         # Extension manifest
├── src/
│   ├── API/
│   │   ├── ItemsAPI.Page.al         # Items API page
│   │   └── SalesOrdersAPI.Page.al   # Sales Orders API page
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
