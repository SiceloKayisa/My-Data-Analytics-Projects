# B2B Courier Charges Accuracy Analysis<br>

**Background Information**<br>

In today’s fast-paced e-commerce industry, fast and efficient order delivery is crucial to business success. To ensure seamless order fulfilment, businesses often partner with courier companies to ship their products to customers. However, managing the charges collected by these courier companies can be difficult, especially when dealing with a high volume of orders. It is one of the real-time problems B2B businesses experience when their estimated charges for the same invoice don’t match. In this project we will analyse a B2B Courier Charges Accuracy using Python.<br>

B2B courier charges accuracy analysis focuses on assessing the accuracy of fees charged by courier companies for the delivery of goods in B2B transactions. The aim is to ensure that companies are billed appropriately for the services provided by courier companies.<br>

**Problem Statement**<br>

**B2B Ecommerce Fraud: Case Study** <br>

ABC Company operates an e-commerce platform and processes thousands of orders daily. To deliver these orders, ABC has partnered with several courier companies in India, which charge them based on the weight of the products and the distance between the warehouse and the customer’s delivery address. ABC wants to check if the fees charged by the courier companies for each order are correct <br>

ABC wants to compare the total weight of each order calculated using the SKU master with the weight stated by the courier company in their invoice. The weight should be rounded up to the nearest multiple of 0.5 kg to determine the weight of the tile. The warehouse PIN to all India Pincode mappings is used to determine the delivery area, which should be compared to the area reported by the courier company.<br> 

In addition, ABC must apply the logic of calculating charges based on the slab weight, delivery area and type of shipment listed on the courier company’s invoice. The courier fee rate card provides a fixed fee and an additional fee for each weight plate and PIN. The total charge per shipment should be calculated by adding the fixed charge and any additional charges based on plate weight.<br>

**Data Description**<br>

ABC has internal data split across three reports: Website Order Report, Master SKU, and Warehouse PIN for all India Pincode mappings. In addition, they receive billing data from courier companies.<br>

The website order report includes order IDs and products (SKUs) for each order. The SKU master provides the gross weight of each product, which is needed to calculate the total weight of each order. Courier company invoices contain information such as AWB number, order ID, shipment weight, warehouse pickup PIN, customer delivery PIN, delivery area, the charge per shipment and type of shipment.

**References**

https://statso.io/b2b-ecommerce-fraud-case-study/
