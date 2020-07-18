PSOUTOR1 ;HPS/DSK - MEDICATION ORDER STATUS CHECK AGAINST ORDERS (#100) FILE ;NOV. 9,2018@16:00
 ;;7.0;OUTPATIENT PHARMACY;**546**;DEC 1997;Build 23
 ;
 Q
 ;
 ;Continuation of PSOUTOR
 ;
 ;;Reference to SENDMSG^XMXAPI supported by IA #2729
 ;
MAIL() ;
 N PSOMES,PSOSUB,PSOMIN,PSOTEXT,PSOMZ,PSOX,Y,PSOMY
 ;
 ;kill ^TMP in case somehow it exists after previously running the option
 S PSOMES="PSOUTOR "_$J
 K ^TMP(PSOMES)
 S PSOSUB="Medication File Search Finished"
 S PSOMIN("FROM")="PSO ORDER STATUS MISMATCH SEARCH ROUTINE"
 S PSOMY(PSODUZ)=""
 S PSOTEXT="^TMP("""_PSOMES_""")"
 S ^TMP(PSOMES,1)=" "
 S ^TMP(PSOMES,2)="SUMMARY"
 S ^TMP(PSOMES,3)="======="
 S ^TMP(PSOMES,4)=" "
 S ^TMP(PSOMES,5)="Search of:"
 S ^TMP(PSOMES,6)=PSOAR(PSOTYP)
 I PSOTYP="ION" S ^TMP(PSOMES,6)=^TMP(PSOMES,6)_" - Inpatient, Outpatient, and Non-VA - "
 S ^TMP(PSOMES,6)=^TMP(PSOMES,6)_" Medication File(s)"
 S Y=PSOSTART X ^DD("DD") S ^TMP(PSOMES,7)="from "_Y_" to "
 S Y=PSOEDT-1 X ^DD("DD") S ^TMP(PSOMES,7)=^TMP(PSOMES,7)_Y
 S ^TMP(PSOMES,8)="The order"_$S(PSOA=1:" was ",1:"s were ")_$S(PSOCORR:"",1:"*** NOT *** ")_"corrected at user's request."
 S ^TMP(PSOMES,9)=" "
 S ^TMP(PSOMES,10)="Orders should be reviewed to confirm if it is appropriate for their statuses"
 S ^TMP(PSOMES,11)="to be matched. The report should then be rerun with the prompt ""Should the"
 S ^TMP(PSOMES,12)="status in the ORDERS (#100) file be corrected automatically? NO//"" answered"
 S ^TMP(PSOMES,13)="""YES"" to have the corrections made."
 S ^TMP(PSOMES,14)=" "
 S ^TMP(PSOMES,15)="Search performed was for orders with a status mismatch where the ORDERS (#100)"
 S ^TMP(PSOMES,16)="file status is active but the status is expired or discontinued in the"
 S ^TMP(PSOMES,17)="PHARMACY PATIENT (#55) or PRESCRIPTION (#52) file."
 S ^TMP(PSOMES,18)=" "
 S ^TMP(PSOMES,19)="The orders are listed in a separate section below."
 S ^TMP(PSOMES,20)="The list of affected order(s) is also stored in the global"
 S ^TMP(PSOMES,21)="^XTMP("""_PSOTMP_""" for 60 days."
 S ^TMP(PSOMES,22)=" "
 S ^TMP(PSOMES,23)="Associated documentation can be found in:"
 S ^TMP(PSOMES,24)="Chapter 27 of the Outpatient Pharmacy (PSO) Manager's User Manual."
 D DETAIL
 D SENDMSG^XMXAPI(PSODUZ,PSOSUB,PSOTEXT,.PSOMY,.PSOMIN,.PSOMZ,"")
 K ^TMP(PSOMES)
 Q PSOMZ
 ;
DETAIL ;
 N PSODASH,PSOSTR,PSODATA,PSOSPACE,PSOY,PSOZ
 S PSODASH="-----------------------------------------------------------------"
 S PSOSPACE="                                                   "
 S ^TMP(PSOMES,25)=" "
 S ^TMP(PSOMES,26)="Detail: ORDERS (#100) File Active / Medication File Not Active"
 S ^TMP(PSOMES,27)="=============================================================="
 S ^TMP(PSOMES,28)=" "
 S ^TMP(PSOMES,29)=$S('PSOA:"No",1:"** "_PSOA_" **")_" mismatches found."
 S PSOX=29
 Q:'PSOA
 ;kill "no issues found" subscript in case research is performed later on ^XMTP
 K ^XTMP(PSOTMP,"A",1)
 S PSOY=""
 F  S PSOY=$O(^XTMP(PSOTMP,"A",PSOY)) Q:PSOY=""  D
 . S PSOX=PSOX+1
 . S ^TMP(PSOMES,PSOX)=" "
 . S PSOX=PSOX+1
 . S ^TMP(PSOMES,PSOX)="Type: "_PSOY
 . D SECTION
 . S PSOZ=""
 . F  S PSOZ=$O(^XTMP(PSOTMP,"A",PSOY,PSOZ)) Q:PSOZ=""  D
 . . S PSOX=PSOX+1,PSOSTR=^XTMP(PSOTMP,"A",PSOY,PSOZ)
 . . D PSOZ
 Q
 ;
SECTION ;
 S PSOX=PSOX+1
 S ^TMP(PSOMES,PSOX)="ORDERS Number Date/Time Ordered  ORDERABLE ITEM Status    Pkg Ref"
 S PSOX=PSOX+1
 S ^TMP(PSOMES,PSOX)=$S(PSOY["Out":"Rx IEN ",PSOY[">":"Med IEN",1:"#55 IEN")
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_"       "_$S(PSOY["VA":"Documented Date   ",PSOY["Out":"Issue Date        ",PSOY[">":"Issue / Start Dt. ",1:"Start Date        ")
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_" DRUG           Status    "_$S(PSOY["VA":"DC Date",1:"Exp. Date")
 S PSOX=PSOX+1
 S ^TMP(PSOMES,PSOX)=$E(PSODASH,1,13)_" "_$E(PSODASH,1,18)_" "_$E(PSODASH,1,14)_" "_$E(PSODASH,1,9)_" "_$E(PSODASH,1,18)
 Q
 ;
PSOZ ;
 ;blank line for ease of readability
 S ^TMP(PSOMES,PSOX)=" ",PSOX=PSOX+1
 ;CPRS ordered date/time
 S PSODATA=$P(PSOSTR,"^",2)
 S ^TMP(PSOMES,PSOX)=PSOZ_$E(PSOSPACE,1,14-$L(PSOZ))_PSODATA_$E(PSOSPACE,1,19-$L(PSODATA))
 ;Orders (#100) file orderable item
 S PSODATA=$E($P(PSOSTR,"^",3),1,14)
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_PSODATA_$E(PSOSPACE,1,15-$L(PSODATA))
 ;Orders (#100) order status
 S PSODATA=$P(PSOSTR,"^",4),PSODATA=$S($E(PSODATA)="D":$E(PSODATA,1,7)_".",1:PSODATA)
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_PSODATA_$E(PSOSPACE,1,10-$L(PSODATA))
 ;Orders (#100) package reference
 S PSODATA=$P(PSOSTR,"^",5)
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_PSODATA
 S PSOX=PSOX+1
 ;Display package reference again except in the second line it also equals
 ;the Outpatient Rx# or the file 55 ien
 S ^TMP(PSOMES,PSOX)=PSODATA_$E(PSOSPACE,1,14-$L(PSODATA))
 ;Start date if UD or IV, Issue date if Outpatient, or documented date for Non-VA med
 S PSODATA=$P($P(PSOSTR,"^",6),":",1,2)
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_PSODATA_$E(PSOSPACE,1,19-$L(PSODATA))
 ;Drug
 S PSODATA=$P(PSOSTR,"^",7),PSODATA=$E(PSODATA,1,14)
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_PSODATA_$E(PSOSPACE,1,15-$L(PSODATA))
 ;Rx status (Abbreviate if discontinued.)
 S PSODATA=$P(PSOSTR,"^",8),PSODATA=$S(PSODATA["Death":PSODATA,$E(PSODATA)="D":$E(PSODATA,1,7)_".",1:PSODATA)
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_PSODATA_$E(PSOSPACE,1,10-$L(PSODATA))
 ;Discontinue or stop date
 S PSODATA=$P($P(PSOSTR,"^",9),":",1,2)
 S ^TMP(PSOMES,PSOX)=^TMP(PSOMES,PSOX)_PSODATA
 Q
 ;
