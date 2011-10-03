IVM273M ;ALB/PDJ IVM*2.0*73 - CLEANUP IVM PATIENT FILE;02/07/2003
 ;;2.0;INCOME VERIFICATION MATCH;**73**; 21-OCT-94
 ;
 ; A mail message will be sent to the user when the edit process
 ; is complete.
 ;
 ;
MAIL ; Send a mailman msg to user with results
 N DIFROM,%
 N DATA,NODE,TEXT,XMDUZ,XMSUB,XMTEXT,XMY,Y
 N XTPAT,NAME
 N PIEN,R3015,SSN
 S XTPAT="IVM*2.0*73-PATREC"
 K ^TMP("IVM2073",$J)
 S XMSUB="IVM PATIENT file Cleanup"
 S XMDUZ="IVM Edit Package",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="^TMP(""IVM2073"",$J,"
 D NOW^%DTC S Y=% D DD^%DT
 S ^TMP("IVM2073",$J,1)="IVM PATIENT file cleanup"
 S ^TMP("IVM2073",$J,2)="  "
 S NODE=2
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=" "
 ;
PRTRECS ; Print List of records
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=" "
 S TEXT="    Total IVM PATIENT Records Updated: "
 S TEXT=$$BLDSTR($J(+$G(^XTMP(XTPAT,1)),8,0),TEXT,50,8)
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=TEXT
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=" "
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=" "
 ;
 S TEXT=" "
 S TEXT=$$BLDSTR("DFN",TEXT,3,3)
 S TEXT=$$BLDSTR("301.5",TEXT,16,5)
 S TEXT=$$BLDSTR("SSN",TEXT,29,3)
 S TEXT=$$BLDSTR("Name",TEXT,43,4)
 S TEXT=$$BLDSTR("Addr?",TEXT,67,5)
 S TEXT=$$BLDSTR("Ph?",TEXT,75,3)
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=TEXT
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=$$REPEAT^XLFSTR("=",79)
 S PIEN=""
 F  S PIEN=$O(^XTMP(XTPAT,"RECS",PIEN)) Q:PIEN=""  D
 . D BLDPAT
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=$$REPEAT^XLFSTR("=",79)
 ;
MAIL1 ;  Send message 
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=" "
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=" ******** END OF MESSAGE ********"
 ;
 D ^XMD
 K ^TMP("IVM2073",$J)
 Q
 ;
BLDPAT ; Format Patient line for printing
 N DATA,NAME,PH,AD
 S DATA=^XTMP(XTPAT,"RECS",PIEN)
 S R3015=$P(DATA,"^",1),NAME=$P(DATA,"^",2),SSN=$P(DATA,"^",3)
 S AD=$P(DATA,"^",4),PH=$P(DATA,"^",5)
 S TEXT=" "
 S TEXT=$$BLDSTR(PIEN,TEXT,3,$L(PIEN))
 S TEXT=$$BLDSTR(R3015,TEXT,16,$L(R3015))
 S TEXT=$$BLDSTR(SSN,TEXT,29,$L(SSN))
 S TEXT=$$BLDSTR($E(NAME,1,20),TEXT,43,20)
 I AD S TEXT=$$BLDSTR("YES",TEXT,68,3)
 I PH S TEXT=$$BLDSTR("YES",TEXT,75,3)
 S NODE=NODE+1
 S ^TMP("IVM2073",$J,NODE)=TEXT
 Q
 ;
BLDSTR(NSTR,STR,COL,NSL) ; build a string
 ; Input:
 ;   NSTR = a string to be added to STR
 ;   STR  = an existing string to which NSTR will be added
 ;   COL  = column location at which NSTR will be added to STR
 ;   NSL  = length of new string
 ; Output:
 ;   returns STR with NSTR appended at the specified COL
 ;
 Q $E(STR_$J("",COL-1),1,COL-1)_$E(NSTR_$J("",NSL),1,NSL)_$E(STR,COL+NSL,999)
