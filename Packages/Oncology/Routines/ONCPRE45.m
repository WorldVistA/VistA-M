ONCPRE45 ;Hines OIFO/GWB - PRE-INSTALL ROUTINE FOR PATCH ONC*2.11*45
 ;;2.11;ONCOLOGY;**45**;Mar 07, 1995
 ;
 ;Kill ONCOLOGY DATA EXTRACT FORMAT (160.16) data
 K ^ONCO(160.16)
 ;
 ;Kill PRIMARY PAYER AT DIAGNOSIS (160.3) data
 K ^ONCO(160.3)
 ;
 ;Delete ONCOLOGY CROSS TAB REPORTS (166) data dictionary
 S DIU="^ONCO(166,",DIU(0)="D" D EN^DIU2
 K DIU Q 