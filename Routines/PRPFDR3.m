PRPFDR3 ;BAYPINES/MJE  VPFS DATA MIGRATION ROUTINE 3 ;05/15/03
 ;;3.0;PATIENT FUNDS DIAG V5.9;**15**;JUNE 1, 1989
 ;ENTRY AT LINETAG ONLY
 Q
RPC(RESULTS,PARAM1,PARAM2) ;ENTRY POINT FOR VPFS RPC
 S PRPFJ=PARAM2
 S PRPFSEG=PARAM1
 I PRPFSEG>1 D SENDSEG Q
TESTRPC ;ENTRY POINT FOR TESTING
 K ^TMP("PRPF_DIAGVL")
 D SETUP^PRPFDR2
 S CNTSEG=1
 S CNTTOT=0
 D XSUM
 D XREP
 S RESULTS=$NA(^TMP("PRPF_DIAGVL",$J,1))
 D KILLIT^PRPFDR4
 Q
SENDSEG ;SEND A SEGMENT OF DATA TO MIGRATION JAVA APP
 S RESULTS=$NA(^TMP("PRPF_DIAGVL",PRPFJ,PRPFSEG))
 Q
SEG ;SET UP NEW SEGMENT NODE
 D:PRPFCNTR=10000
 .S CNTSEG=CNTSEG+1
 .S CNTTOT=CNTTOT+PRPFCNTR
 .S PRPFCNTR=0
 Q
XREP S (PFX,PFY,PFZ,PFNAME)=""
 F  S PFX=$O(^TMP("PRPF_DIAGX",$J,PFX)) Q:PFX=""  D
 .F  S PFY=$O(^TMP("PRPF_DIAGX",$J,PFX,PFY)) Q:PFY=""  D
 ..F  S PFZ=$O(^TMP("PRPF_DIAGX",$J,PFX,PFY,PFZ)) Q:PFZ=""  D
 ...S PFTEMP=^TMP("PRPF_DIAGX",$J,PFX,PFY,PFZ)
 ...S PRPFCNTR=PRPFCNTR+1
 ...S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="STATION ID="_PFX_"^ERR#="_PFY_"^NAME="_PFZ_"^DESC="_$P(PFTEMP,"^",2)_"^VALUE=>"_$P(PFTEMP,"^",3)_"<"
 ...D SEG
 S CNTTOT=CNTTOT+PRPFCNTR
 S ^TMP("PRPF_DIAGVL",$J,0)=DTIME_"^"_"DTIME"_"^"_"PRPF MIGRATION DIAGNOSTIC TEMP DATA SENT TO J2EE"
 S ^TMP("PRPF_DIAGVL",$J,1,0)="VPFS"_U_PFSITE_U_U_U_U_"0"_U_"A1"_U_CNTREC_U_CNTTOT_U_$J
 K ^TMP("PRPF_DIAGX")
 Q
XSUM ;THIS ENTRY POINT FOR VISTALINK
 S PRPFCNTR=0
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="**************************************************************************"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="**      Patient Funds Diagnostic Summary LEGACY RPC    (version 5.9)    **"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="**************************************************************************"
 D SEG
 D NOW^%DTC S Y=% D DD^%DT
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="Run Date: "_$P(Y,"@",1)_"  Run Time: "_$P(Y,"@",2)_$P("       "," ",1,7-$L(CNTREC))_"                            **"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="Total accounts processed = "_CNTREC_$P("       "," ",1,7-$L(CNTREC))_"                                       **"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="Total balance of accounts for migration = $"_$FN(CNTBAL,",",2)_$P("              "," ",1,14-$L($FN(CNTBAL,",",2)))_"                **"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="**************************************************************************"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="Err#    Field           Error                                        Total"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #      Name            Description                                  Count"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="**************************************************************************"
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #1     NAME            Name is blank                                   "_CNTERR(1)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #2     NAME            Name contains invalid data                      "_CNTERR(2)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #3     SSN             SSN is blank                                    "_CNTERR(3)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #4     SSN             SSN contains invalid data                       "_CNTERR(4)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #5     SSN             SSN contains duplicate value                    "_CNTERR(5)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #6     SSN             SSN contains Pseudo SSN value                   "_CNTRPSU
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #7     DOB             DOB is blank                                    "_CNTERR(7)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #8     DOB             DOB contains invalid date                       "_CNTERR(8)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #9     WARD            Ward loc invalid length                         "_CNTERR(9)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #10    CLAIM           Claim # contains invalid data                   "_CNTERR(10)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #11    ZIP             Zipcode contains invalid data                   "_CNTERR(11)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #12    REGION OFFICE   Regional Office ID invalid data                 "_CNTERR(12)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #13    ICN             ICN Duplicate                                   "_CNTERR(13)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #14    ICN             ICN unassigned or invalid                       "_CNTERR(14)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)=" #15    PROVIDER AUTHR  Provider Name contains invalid data             "_CNTERR(15)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#16    PROVID AUTH DT  Date of current restriction invalid date        "_CNTERR(16)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#17    NO DEMO REC     No demographic record for account               "_CNTERR(17)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#18    ACCOUNT STATUS  Account status not (A),I,Blank="_PRPFBC18_$P("      "," ",1,6-$L(PRPFBC18))_"            "_CNTERR(18)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#19    PATIENT TYPE    Patient type not L,R,(U),X,Blank="_PRPFBC19_$P("      "," ",1,8-$L(PRPFBC19))_"        "_CNTERR(19)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#20    PAT TYPE/PHY    Patient type L or R without Phy name            "_CNTERR(20)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#21    PATIENT STATUS  Patient Status not A,R,C,N,(X),Blank="_PRPFBC21_$P("      "," ",1,6-$L(PRPFBC21))_"      "_CNTERR(21)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#22    INDIGENT        Indigent status not (N),Y,Blank="_PRPFBC22_$P("      "," ",1,6-$L(PRPFBC22))_"           "_CNTERR(22)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#23    APPORTIONEE $   Apportionee amount invalid or < $0 or > $99,999 "_CNTERR(23)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#24    GUARDIAN $      Guardian amount invalid or < $0 or > $99,999    "_CNTERR(24)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#25    INSTITUT AWARD  Institut award invalid or < $0 or > $99,999     "_CNTERR(25)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#26    OTHER ASSETS    Other assets invalid or < $0 or > $99,999       "_CNTERR(26)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#27    STORED BALANCE  Stored balance invalid or < $0 or > $99,999     "_CNTERR(27)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#28    STORED PRIVATE  Stored private invalid or < $0 or > $99,999     "_CNTERR(28)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#29    STORED GRATUIT  Stored gratuitous invalid or < $0 or > $99,999  "_CNTERR(29)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#30    RESTRCT MONTH   Restricted Monthly invalid or < $0 or > $99,999 "_CNTERR(30)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#31    RESTRCT WEEKLY  Restricted Weekly invalid or < $0 or > $99,999  "_CNTERR(31)
 D SEG
 S PRPFCNTR=PRPFCNTR+1 S ^TMP("PRPF_DIAGVL",$J,CNTSEG,PRPFCNTR)="*#32    RESTRCT AMT ER  Restrict Mnthly amount > (5X) weekly amt        "_CNTERR(32)
 D SEG
 D XSUM1^PRPFDR6
 Q
