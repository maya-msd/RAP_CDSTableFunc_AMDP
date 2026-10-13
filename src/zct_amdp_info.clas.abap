CLASS zct_amdp_info DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_info FOR TABLE FUNCTION zcds_tbf.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zct_amdp_info IMPLEMENTATION.

  METHOD get_info BY DATABASE FUNCTION
                  FOR HDB
                  LANGUAGE SQLSCRIPT
                  OPTIONS READ-ONLY
                  USING zcinv.

    RETURN SELECT
      mandt,
      kunnr,
      belnr,
      netpr,
      idate,
      pdate,
      CASE prty
        WHEN 'L' THEN 'Low'
        WHEN 'H' THEN 'High'
        WHEN 'M' THEN 'Medium'
        ELSE 'Unknown'
      END AS prty,
      CASE
        WHEN DAYS_BETWEEN(idate, pdate) BETWEEN 1 AND 30  THEN netpr * 3 / 100
        WHEN DAYS_BETWEEN(idate, pdate) BETWEEN 31 AND 60 THEN netpr * 4 / 100
        WHEN DAYS_BETWEEN(idate, pdate) > 60              THEN netpr * 5 / 100
        ELSE 0
      END AS interest,
      DAYS_BETWEEN(idate, pdate) AS due_days
    FROM zcinv;

  ENDMETHOD.

ENDCLASS.
