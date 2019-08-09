XUMVINPA ;MVI/DRI Master Veteran Index New Person Add API ;6/4/19  16:01
 ;;8.0;KERNEL;**711**;Jul 10, 1995;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**711 - STORY 978382 (dri) new routine - new person add api
 ;
 Q
 ;
ADDUSER(XUARR) ;Add a new user using minimum attributes for user identification of
 ; PPMS (Provider Profile Management System) PIE (Provider Integration Engine)
 ;
 ; This interface is available under a private Integration Agreement (#7062) in
 ; support of PPMS PIE only, and should not be used under any other circumstances.
 ;
 ; Input:
 ;    XUARR("NAME") = NAME  surname|first name|middle name|suffix|full .01 name
 ;    XUARR("NPI")  = NPI (National Provider Identifier)
 ;
 ; Return:
 ;    Fail    = "-1^Error Message"
 ;    Success = IEN^#.01 NAME field^1  add of NEW PERSON (#200) file entry
 ;            = IEN                    person already exists
 ;              (Note: this routine will NOT set DUZ to the identified IEN)
 ;
 ; Example:
 ;     S NEWDUZ=$$ADDUSER^XUMVINPA(.XUARR)
 ;
 ;
 N XUDUZ,ERRMSG
 ;
 I '$$CHKDGT^XUSNPI($G(XUARR("NPI"))) Q "-1^Invalid NPI" ;#41.99 - NPI
 S XUDUZ=+$O(^VA(200,"ANPI",XUARR("NPI"),0)) ;does user already exist
 I XUDUZ Q XUDUZ ;per chris, if person already exists, return duz regardless if active and don't udpate
 ;
 I $P($G(XUARR("NAME")),"|",5)="" Q "-1^Subject NAME is required to add a new user" ;#.01 - NAME
 ;
 S XUDUZ=$$ADDU($P(XUARR("NAME"),"|",5)) ;Put the name in the .01 field first, pass back all three pieces to identify an add
 I +XUDUZ<1 Q "-1^Create of new user record failed"
 ;
 S ERRMSG=$$UPDU(.XUARR,XUDUZ) ;then update the remaining fields, no checks if validation issues
 ;
 Q XUDUZ ;duz of new person
 ;
ADDU(XUNAME) ;Add new name to the New Person File
 N DD,DO,DIC,DA,X,Y
 K ^TMP("DIERR",$J)
 S DIC="^VA(200,",DIC(0)="F",X=XUNAME
 ; Get a LOCK. Block if can't get.
 L +^VA(200,0):10 Q:'$T "-1^Addition of new users is blocked"
 D FILE^DICN
 L -^VA(200,0)
 Q Y
 ;
UPDU(XUARR,XUDUZ) ;Update user in the New Person File with Enterprise View
 N DIC,FDA,IEN,X,XUKEY,Y
 K ^TMP("DIERR",$J)
 S IEN=+XUDUZ_","
 S FDA(200,IEN,41.99)=XUARR("NPI") ;NPI
 ;
 F XUKEY="XUORES","PROVIDER" K DIC S DIC="^DIC(19.1,",DIC(0)="MZ",X=XUKEY D ^DIC Q:Y<0  D  ;give user XUORES & PROVIDER keys
 .I $D(^VA(200,XUDUZ,51,"B",+Y)) Q  ;user already has key
 .S FDA(200.051,"+"_+Y_","_IEN,.01)=+Y ;key
 .S FDA(200.051,"+"_+Y_","_IEN,1)=DUZ ;given by
 .S FDA(200.051,"+"_+Y_","_IEN,2)=DT ;date given
 ;
 ; Apply all the changes
 I $D(FDA) K IEN D UPDATE^DIE(,"FDA","IEN") ;File all the data
 ;I $D(^TMP("DIERR",$J)) Q "-1^FileMan error"  ;FileMan Error
 Q ""
 ;
