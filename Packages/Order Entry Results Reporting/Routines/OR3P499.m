OR3P499 ;WILM/BDB - Post Install 499 ;Jan 12, 2023@18:43:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**499**;Dec 17, 1997;Build 165
 ;
POST ; Post-Install for OR*3.0*499
 D PUT^XPAR("SYS","OR ZIP CODE SWITCH",1,1) ;ZIP code check yes enabled
 Q
 ;
