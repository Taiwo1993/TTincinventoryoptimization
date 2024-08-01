-- This shows the total number of units sold per product SKU

-- Top 5

Select productid As "Product ID",
Sum (inventoryquantity) AS Total_Units_Sold
From sales
Group By productid
Order BY Total_Units_Sold DESC
Limit 5;

-- Least 5

Select productid As "Product ID",
Sum (inventoryquantity) AS Total_Units_Sold
From sales
Group By productid
Order BY Total_Units_Sold ASC
Limit 5;


-- This shows the product category that had the highest sales volume last month

Select
P.productcategory As "Product Category",
Sum (S.inventoryquantity) AS Sales_Volume
From sales S
Join product P
On P.productid= S.productid
Where S.sales_year = '2021' And S.sales_month ='11'
Group By P.productcategory
Order By Sales_Volume DESC;

-- This shows how inflation rate correlate with sales volume for a specific month

Select
S.sales_month As "Sales Month",
S.sales_year As "Sales Year",
Sum(S.inventoryquantity) As "Total Sales Volume",
Round(Avg(F.inflationrate),2) AS " Average Inflation Rate"
From sales S
Join factors F On S.salesdate= F.salesdate
Group BY S.sales_year, S.sales_month
Order BY S.sales_month ASC;

--This shows the correlation between the inflation rate and sales quantity for all products
--combined on a monthly basis over the last year

Select
S.sales_year As "Sales Year",
S.sales_month As "Sales Month",
Sum(S.inventoryquantity) As "Total Sales Volume",
Round(Avg(F.inflationrate),2) AS " Average Inflation Rate"
From sales S
Join factors F On S.salesdate= F.salesdate
Where S.salesdate>=(Current_Date - Interval '1 year')
Group BY S.sales_month, S.sales_year
Order BY S.sales_month, S.sales_year;


--This shows if promotions significantly impact the sales quantity of products

Select
P.productcategory As "Product Category",
P.promotions As "Promotions",
Round(Avg(S.inventoryquantity)) As "Quantity Sold"
From product P
Join sales S On P.productid= S.productid
Where P.promotions= 'Yes'
Group BY P.productcategory, P.promotions
Union All
Select
P.productcategory As "Product Category",
P.promotions As "Promotions",
Round(Avg(S.inventoryquantity)) As "Quantity Sold"
From product P
Join sales S On P.productid= S.productid
Where P.promotions= 'No'
Group BY P.productcategory, P.promotions

-- This shows the average sales quantity per product category

Select
P.productcategory As "Product Category",
Round(Avg(S.inventoryquantity)) As Sales_Quantity
From sales S
Join product P
On S.productid = P.productid
Group By P.productcategory
Order By Sales_Quantity DESC

--This shows how GDP affect the total sales volume

Select
S.sales_year As "Sales Year",
Sum(F.gdp) As "Total GDP",
Sum(S.inventoryquantity) As " Total Sales Volume"
From
factors F
Join
sales S On F.salesdate= S.salesdate
Group By S.sales_year
Order By S.sales_year;

-- This shows the top 10 best-selling product SKUs

Select productid As "Product ID",
Sum (inventoryquantity) AS Total_Units_Sold
From sales
Group By productid
Order By Total_Units_Sold DESC
LIMIT 10;

-- This shows how seasonal factors influence sales quantities for different product categories

Select
P.productcategory AS "Product Category",
Round(AVG(F.seasonalfactor),4) AS Average_Seasonal_Factor,
Sum(S.inventoryquantity) AS "Total Sales"
From Sales S
Join product P On P.productid= S.productid
Join factors F On F.salesdate = S.salesdate
Group By P.productcategory
Order By Average_Seasonal_Factor
There is no direct impact of the Average Seasonal Factor on sales volume across product
categories. It is recommended to maintain consistent output levels regardless of seasonal
variations.
10 | P a g e
What is the average sales quantity per product category, and how many products within
each category were part of a promotion?
Select
P.productcategory AS "Product Category",
Round(AVG(S.inventoryquantity)) AS Sales_Quantity,
Count(Case
When P.promotions = 'Yes' Then 1
End) AS "Promotion Count"
From Sales S
Join product P On S.productid = P.productid
Group By P.productcategory
Order BY Sales_Quantity;
Insights
The analysis indicates no direct correlation between sales quantity by product category and
promotions. For instance, Electronics leads in sales quantity with only 212 promotions, while
Home Appliances has the highest number of promotions but lower sales volume.
Recommendation
Reduce overall investment expenditures and reallocate funds to enhance production of topselling
products.
