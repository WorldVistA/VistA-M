MCAIPST ; HISC/NCA - Post-Init Conversions ;9/29/95  14:14
 ;;2.3;Medicine;**5**;09/13/1996
EN1 ; Remove Old MC Routines that Reference FILE 3, 6, or 16
 Q:$$VERSION^XPDUTL("MC")'=2.3
 F X="MCMENUDE","MCPOS02" X ^%ZOSF("DEL")
 K X Q
