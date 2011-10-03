TIULAPIS ; SLC/JER - Extract selected documents from TIU ; 9/19/07 2:39pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,121,211,227**;Jun 20, 1997;Build 15
MAIN(DFN,TIUDOC,STATUS,TIME1,TIME2,OCCLIM,TEXT) ; Control branching
 N TIUDA,TIUDT,TIUPRM0,TIUPRM1,TIUPRM3,COUNT,TIUSI,TIUS,TIUTI
 N CANDO,OLDRPARY,TIUDOCI,CKCANVW,ORIGCHLD
 D SETPARM^TIULE
 S:+$G(OCCLIM)'>0 OCCLIM=999
 S:+$G(TIME1)'>0 TIME1=6666666
 S:+$G(TIME2)'>0 TIME2=9999999
 K ^TMP("TIU",$J),^TMP("TIUREPLACE",$J)
 I '$D(TIUPRM0) D SETPARM^TIULE
 I $D(TIUDOC)'>0 Q
 I $D(STATUS)'>9 D STATUS^TIUSRVL(.STATUS,$S($G(STATUS)]"":STATUS,1:"ALL"))
 S TIUTI=0 F  S TIUTI=$O(TIUDOC(TIUTI)) Q:+TIUTI'>0  D  ;TIUTI=1,2,3...
 . S TIUDOC=+$G(TIUDOC(TIUTI)),COUNT=0
 . S TIUSI=0 F  S TIUSI=$O(STATUS(TIUSI)) Q:+TIUSI'>0  D
 . . S TIUS=+$G(STATUS(TIUSI)),TIUDT=TIME1
 . . F  S TIUDT=$O(^TIU(8925,"APT",DFN,TIUDOC,TIUS,TIUDT)) Q:+TIUDT'>0!(TIUDT>TIME2)!(+$G(COUNT)'<OCCLIM)  D
 . . . S TIUDA=0 F  S TIUDA=$O(^TIU(8925,"APT",DFN,TIUDOC,TIUS,TIUDT,TIUDA)) Q:+TIUDA'>0  D
 . . . . I +$$ISADDNDM^TIULC1(TIUDA),+TEXT Q
 . . . . ; -- CKCANVW: If user is viewing, check in REPLACE if user
 . . . . ;    can view, and add record to ^TMP("TIUREPLACE",$J) only if user
 . . . . ;    can view.  Tell EXTRACT it doesn't need to check again
 . . . . ;    when EXTRACT loops thru ^TMP("TIUREPLACE",$J).
 . . . . S CKCANVW=$S($E(IOST,1)="C":1,1:0)
 . . . . I $E(IOST,1)'="C" S CANDO=+$$CANDO^TIULP(TIUDA,"PRINT RECORD") Q:'CANDO  ;TIU*1*91
 . . . . ; -- Since ID children must print as part of the whole ID
 . . . . ;    note, set array ^TMP("TIUREPLACE",$J) of standalone notes
 . . . . ;    and ID parents.
 . . . . ;    Add TIUDA to ^TMP("TIUREPLACE",$J), replacing TIUDA
 . . . . ;    w its ID parent IFN if TIUDA is an ID kid.
 . . . . ;    Raise count of records if "good" element was added
 . . . . ;    to ^TMP("TIUREPLACE",$J).
 . . . . S OLDRPARY=$G(^TMP("TIUREPLACE",$J)) ;How many "GOOD" elements in array
 . . . . D REPLACE^TIUPRPN3(TIUDA,TIUDT,1301,CKCANVW)
 . . . . S COUNT=COUNT+^TMP("TIUREPLACE",$J)-OLDRPARY
 . . . . S ^TMP("TIU",$J,TIUDT,TIUTI,0)=COUNT
 . . . . ; -- Track which title to collate TIUDA with:
 . . . . S TIUDOCI(TIUDA)=TIUTI
 ; -- Loop thru array of standalone or ID parent records and
 ;    set ^TMP("TIU",$J for each record.
 S TIUDA=0
 F  S TIUDA=$O(^TMP("TIUREPLACE",$J,TIUDA)) Q:'TIUDA  D
 . Q:^TMP("TIUREPLACE",$J,TIUDA)=0  ;User can't view
 . S TIUDT=^TMP("TIUREPLACE",$J,TIUDA,"DT")
 . ; -- ORIGCHLD: If a parent is added to array solely on merit
 . ;    of an ID kid, retrieve the child that meets the criteria
 . ;    and collate w child title:
 . S ORIGCHLD=+$P(^TMP("TIUREPLACE",$J,TIUDA),U,2)
 . S TIUTI=$G(TIUDOCI(TIUDA)) I 'TIUTI S TIUTI=$G(TIUDOCI(ORIGCHLD))
 . ;VMP/RJT - *227
 . D EXTRACT^TIULQ(TIUDA,"^TMP(""TIU"","_$J_","_TIUDT_","_TIUTI_")",.TIUERR,".01;.05;.07;.08;1202;1203;1205;1208;1209;1301;1307;1402;1501:1505;1507:1513;1601;1701;89261","",1,"IE",CKCANVW,ORIGCHLD)
 K ^TMP("TIUREPLACE",$J)
 Q
