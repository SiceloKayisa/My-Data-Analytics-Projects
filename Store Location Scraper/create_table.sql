USE master;
GO

IF OBJECT_ID('dbo.Stores', 'U') IS NOT NULL
    DROP TABLE dbo.Stores;
GO

CREATE TABLE dbo.Stores (
    -- Primary Key: Automatically increments for each new store
    -- For databases naming columns using Pascal case is recommended
    -- So then I decided to rename columns differently here
    StoreID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    
    -- Store Information
    StoreName NVARCHAR(150) NOT NULL,
    StoreAddress NVARCHAR(255) NULL, 
    Country NVARCHAR(255) NULL,
    Province NVARCHAR(255) NULL,
    City NVARCHAR(255) NULL,
    Location NVARCHAR(255) NULL,
    PostalCode VARCHAR(10) NULL,
    Latitude DECIMAL(9, 6) NULL,
    Longitude DECIMAL(10, 6) NULL,
    Phone NVARCHAR(50) NULL,
    Email NVARCHAR(100) NULL,
    FacebookURL NVARCHAR(255) NULL,
    URL NVARCHAR(255) NULL,
    
    -- Audit fields. Creating Timestamp
    DateExtracted DATETIME DEFAULT GETDATE()
);

GO
