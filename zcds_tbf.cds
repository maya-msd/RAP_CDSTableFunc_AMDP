@EndUserText.label: 'CDS Table Function for Interest & Aging Calculation'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.type: #CLIENT_DEPENDENT

define table function zcds_tbf
returns {
  mandt    : abap.clnt;
  kunnr    : kunnr;
  belnr    : belnr_d;
  netpr    : abap.int8;
  idate    : abap.dats;
  pdate    : abap.dats;
  prty     : abap.char(10);
  interest : abap.int8;
  due_days : abap.int4;
}
implemented by method zct_amdp_info=>get_info;
