# RAP_CDSTableFunc_AMDP
Creating a CDS table function and utilizing it through AMDP(ABAP Managed Database Procedures) so that all the arithmetic calculations can be carried out at the HANA database using SQLSCRIPT
# SAP S/4HANA: CDS Table Function via AMDP (SQLScript Engine)

Implementation of an SAP Core Data Services (CDS) Table Function backed by ABAP Managed Database Procedures (AMDP) to perform complex arithmetic operations and date calculations directly in the SAP HANA database layer.

## Architecture & Design Purpose

Standard CDS view entities provide standard SQL modeling capabilities but cannot handle complex, iterative, or database-native procedural arithmetic calculations. CDS Table Functions bridge this gap by delegating data processing to AMDP database functions written in native HANA SQLScript.

### 1. CDS Table Function (`zcds_tbf.cds`)
* Defines the typed output structure (`mandt`, `kunnr`, `belnr`, `netpr`, `interest`, `due_days`).
* Binds the execution directly to an AMDP class method using `implemented by method zct_amdp_info=>get_info`.

### 2. AMDP Class & Method (`zct_amdp_info.clas.abap`)
* **Interface**: Implements `if_amdp_marker_hdb` to mark the ABAP class as an AMDP container for SAP HANA.
* **Database Function**: Defined using `BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zcinv`.
* **Code-Pushdown Logic**:
  * Utilizes native HANA SQLScript function `DAYS_BETWEEN(idate, pdate)` to calculate overdue days.
  * Calculates tiered interest rates dynamically (`3%`, `4%`, `5%`) based on aging intervals.
  * Normalizes priority codes (`L`, `H`, `M`) into descriptive labels (`Low`, `Medium`, `High`) via SQL `CASE` expressions.

### 3. Open SQL Consumer (`zreport_amdp_tbf.abap`)
* Demonstrates seamless consumption of the table function as a standard tabular data source in ABAP with inline data declarations (`@DATA(...)`).

## Technologies Used
* SAP Core Data Services (CDS Table Functions)
* ABAP Managed Database Procedures (AMDP)
* SAP HANA SQLScript
* ABAP Open SQL (Inline Declarations)
* Eclipse ADT
