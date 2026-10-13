*&---------------------------------------------------------------------*
*& Report zreport_amdp_tbf
*& Consuming CDS Table Function via Modern ABAP SQL
*&---------------------------------------------------------------------*
REPORT zreport_amdp_tbf.

START-OF-SELECTION.

  " Select directly from CDS Table Function populated by the AMDP HANA engine
  SELECT *
    FROM zcds_tbf
    INTO TABLE @DATA(it_invoice_calc)
    UP TO 100 ROWS.

  IF it_invoice_calc IS NOT INITIAL.
    cl_demo_output=>display( it_invoice_calc ).
  ELSE.
    MESSAGE 'No invoice records retrieved from AMDP table function.' TYPE 'I'.
  ENDIF.
