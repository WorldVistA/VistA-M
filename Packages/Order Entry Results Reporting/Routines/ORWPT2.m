ORWPT2 ; SLC/JLC - Patient Lookup Functions (cont) ;04/10/2020
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**485**;Dec 17, 1997;Build 16
 ;
COVID(Y,DFN) ; return COVID-19 statuses
 N A,RIEN
 S RIEN=+$$GET^XPAR("ALL","OR OTHER INFO REMINDER",1,"I")
 I RIEN=0 S Y="-1^No Reminder definition is defined"
 ;ICR #7146
 S Y=$$STATUS^PXRMCOVID19(DFN,RIEN)
 Q Y
