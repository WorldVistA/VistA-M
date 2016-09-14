PSSP194 ;DAL/DSK-PSS*1.0*194 POST INSTALL ROUTINE
 ;;1.0;PHARMACY DATA MANAGEMENT;**194**;9/30/97;Build 9
 ;;
 Q
 ;
POSTINT ; POST INSTALL ENTRY POINT.
 ;
 N ZTDESC,ZTIO,ZTDTH,ZTRTN,ZTSAVE
 S ZTDESC="PSS*1*194 Post Install",ZTIO="",ZTDTH=$H,ZTRTN="POST^PSSP194",ZTSAVE("DUZ")=""
 D ^%ZTLOAD
 D BMES^XPDUTL("PSS*1*194 Post Install Task Queued.")
 D BMES^XPDUTL("You will receive a MailMan message")
 D BMES^XPDUTL("when task #"_$G(ZTSK)_" has completed.")
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 Q
 ;
POST ;correct cross references and send mail message
 ;
 ;  ^XTMP("PSSP194" used to document changes made
 ;  Changes are sent in MailMan message to installer
 ;  ^XTMP is kept for 90 days in case questions arise later
 ;  and mail message has been deleted
 ;
 N PSSNOW
 S PSSNOW=$$NOW^XLFDT()
 ;in case this routine is run more than once, delete old ^XTMP entry
 K ^XTMP("PSSP194")
 S ^XTMP("PSSP194",0)=$$FMADD^XLFDT(PSSNOW,90)_"^"_PSSNOW_"^PSS*1.0*194 Post Install Routine PSSP194"
 D NAME,MAIL
 Q
 ;
NAME ;Search for incorrect cross references
 ;If length is exactly 30, pre-PSS*1*194 version of PSSTXT
 ;may not have deleted or changed the cross reference correctly
 ;If length is more than 30, change to 30 to be consistent
 ;with FileMan logic
 ;
 N PSSEQ,PSSTR,PSSIEN,PSSINDEX
 D CHECK
 ;
 S PSSEQ=""
 ;
 ;Delete cross references which need to be deleted
 F  S PSSEQ=$O(^XTMP("PSSP194","CROSS",PSSEQ)) Q:PSSEQ=""  D
 . S PSSTR=^XTMP("PSSP194","CROSS",PSSEQ)
 . S PSSIEN=$P(PSSTR,"^"),PSSINDEX=$P(PSSTR,"^",3)
 . K ^PS(51.7,"B",PSSINDEX,PSSIEN)
 ;
 ;Set cross references which need to  be set
 F  S PSSEQ=$O(^XTMP("PSSP194","B_SET",PSSEQ)) Q:PSSEQ=""  D
 . S PSSTR=^XTMP("PSSP194","B_SET",PSSEQ)
 . S PSSIEN=$P(PSSTR,"^"),PSSINDEX=$P(PSSTR,"^",3)
 . S ^PS(51.7,"B",PSSINDEX,PSSIEN)=""
 ;
 ;Kill long cross references and set truncated cross references
 F  S PSSEQ=$O(^XTMP("PSSP194","LONG",PSSEQ)) Q:PSSEQ=""  D
 . S PSSTR=^XTMP("PSSP194","LONG",PSSEQ)
 . ;kill the >30 length cross reference
 . S PSSIEN=$P(PSSTR,"^"),PSSINDEX=$P(PSSTR,"^",2)
 . K ^PS(51.7,"B",PSSINDEX,PSSIEN)
 . ;set correct cross reference.
 . ;This set could potentially occur twice due to part IND
 . ;but at least it would be set.
 . S PSSINDEX=$P(PSSTR,"^",3)
 . ;check for null value in case this was a file fragment
 . I PSSINDEX]"" S ^PS(51.7,"B",PSSINDEX,PSSIEN)=""
 Q
 ;
CHECK ;Check cross reference and correct if necessary
 ;
 N PSSNAME,PSSUB
 S PSSINDEX="",PSSEQ=0
 F  S PSSINDEX=$O(^PS(51.7,"B",PSSINDEX)) Q:PSSINDEX=""  D
 . Q:$L(PSSINDEX)<30
 . S PSSIEN=""
 . F  S PSSIEN=$O(^PS(51.7,"B",PSSINDEX,PSSIEN)) Q:PSSIEN=""  D
 . . S PSSNAME=$P($G(^PS(51.7,PSSIEN,0)),"^")
 . . I $E(PSSNAME,1,30)'=PSSINDEX D
 . . . ;"CROSS" subscript = cross reference was not deleted 
 . . . ;                    because of previous logic issue
 . . . ;                    in routine PSSTXT so need to delete
 . . . ;"LONG" subscript  = cross reference is longer than
 . . . ;                    30 characters; truncate to 30
 . . . ;                    to be consistent with FileMan
 . . . S PSSEQ=PSSEQ+1,PSSUB=$S($L(PSSINDEX)=30:"CROSS",1:"LONG")
 . . . ;set data string for ease of sending MailMan message later
 . . . S ^XTMP("PSSP194",PSSUB,PSSEQ)=PSSIEN_"^"_$S(PSSUB="CROSS":PSSNAME,1:PSSINDEX)_"^"_$S(PSSUB="CROSS":PSSINDEX,1:$E(PSSNAME,1,30))
 . . . D IND
 Q
 ;
IND ;double check to make sure there is a valid index
 ;
 I PSSNAME'="",'$D(^PS(51.7,"B",PSSNAME,PSSIEN)),'$D(^PS(51.7,"B",$E(PSSNAME,1,30),PSSIEN)) D
 . ;For an unknown reason, the name is not present -- truncated or not
 . ; -- as a cross reference.
 . ;This is probably not a real issue at sites, but am allowing for the
 . ;possibility.
 . ;
 . ;If PSSNAME is null, a file fragment probably exists which was caused
 . ;by a previous error.  Leave the file fragment "as is" because side
 . ;effects of deleting file fragments are not known.
 . ;
 . S ^XTMP("PSSP194","B_SET",PSSEQ)=PSSIEN_"^"_PSSNAME_"^"_$E(PSSNAME,1,30)
 Q
 ;
MAIL ;send Mail message
 ;
 N XMY,PSLINE,PSSPACE,XMDUZ,XMY,XMSUB,A,XMTEXT,PSFLG
 K XMY
 S PSFLG=0,PSLINE=1,PSSPACE="                                        "
 ;send MailMan message to installer
 S XMDUZ="POST-INSTALL,PSS*1.0*194",XMY(DUZ)="",XMSUB="POST-INSTALL PSS*1.0*194 INFORMATION"
 S A(PSLINE)=""
 S PSLINE=PSLINE+1
 S A(PSLINE)="    PSS*1.0*194 POST-INSTALL"
 S PSLINE=PSLINE+1
 S A(PSLINE)=" "
 S A(PSLINE)="    The content of this message is informational only."
 S PSLINE=PSLINE+1
 S A(PSLINE)="    No action needs to be taken."
 S PSLINE=PSLINE+1
 S A(PSLINE)=" "
 S PSSEQ=""
 F  S PSSEQ=$O(^XTMP("PSSP194",PSSEQ)) Q:PSSEQ=""  D
 . I PSSEQ="CROSS" S PSFLG=1 D MCROSS
 . I PSSEQ="B_SET" S PSFLG=1 D MBSET
 . I PSSEQ="LONG" S PSFLG=1 D MLONG
 I 'PSFLG D
 . S PSLINE=PSLINE+1
 . S A(PSLINE)="    The DRUG TEXT (#51.7) file was checked and no issues were found."
 ;set mail message in ^XTMP in case mail message accidentally deleted
 M ^XTMP("PSSP194","MAIL")=A
 ;send mail message
 S XMTEXT="A(" D ^XMD
 ;delete task from TaskManager list
 S ZTREQ="@"
 Q
 ;
MCROSS ;Incorrect cross reference was deleted
 ;
 N PSSUB,PSSTR,PSSIEN,PSSNAME,PSSCROSS
 ;set top level of ^XMTP subscript for ease of troublehshooting later if necessary
 S ^XTMP("PSSP194",PSSEQ)="Incorrect Cross References which were deleted by post-install routine PSSP194"
 S PSLINE=PSLINE+1
 S A(PSLINE)=" "
 S PSLINE=PSLINE+1
 S A(PSLINE)="The following entries in the DRUG TEXT (#51.7) file had"
 S PSLINE=PSLINE+1
 S A(PSLINE)="incorrect cross references deleted."
 S PSLINE=PSLINE+1
 S A(PSLINE)=" "
 S PSLINE=PSLINE+1
 S A(PSLINE)="    IEN          Name"
 S PSLINE=PSLINE+1
 S A(PSLINE)="    ------------ ---------------------------------------------"
 S PSLINE=PSLINE+1
 S A(PSLINE)="                      Incorrect Cross Reference Deleted"
 S PSLINE=PSLINE+1
 S A(PSLINE)="                      ---------------------------------------"
 D STR
 Q
 ;
MBSET ;No cross references existed, so cross references were set
 ;
 N PSSUB,PSSTR,PSSIEN,PSSNAME,PSSCROSS
 ;set top level of ^XTMP subscript for ease of troubleshooting later if necessary
 S ^XTMP("PSSP194",PSSEQ)="No cross references existed, so cross reference was set"
 S PSLINE=PSLINE+1
 S A(PSLINE)="The following entries in the DRUG TEXT (#51.7) file had no cross references,"
 S PSLINE=PSLINE+1
 S A(PSLINE)="so cross references were set."
 S PSLINE=PSLINE+1
 S A(PSLINE)=""
 S PSLINE=PSLINE+1
 S A(PSLINE)="    IEN          Name"
 S PSLINE=PSLINE+1
 S A(PSLINE)="    ------------ ---------------------------------------------"
 S PSLINE=PSLINE+1
 S A(PSLINE)="                      Cross Reference Set"
 S PSLINE=PSLINE+1
 S A(PSLINE)="                      ------------------------------"
 D STR
 Q
 ;
MLONG ;Long cross references which were truncated
 ;
 N PSSUB,PSSTR,PSSIEN,PSSCROSS
 ;set top level of ^XTMP subscript for ease of troubleshooting later if necessary
 S ^XTMP("PSSP194",PSSEQ)="Long cross references which were truncated"
 S PSLINE=PSLINE+1
 S A(PSLINE)=" "
 S PSLINE=PSLINE+1
 S A(PSLINE)="The following entries in the DRUG TEXT (#51.7) file had long"
 S PSLINE=PSLINE+1
 S A(PSLINE)="cross references deleted and truncated cross references set."
 S PSLINE=PSLINE+1
 S A(PSLINE)=""
 S PSLINE=PSLINE+1
 S A(PSLINE)="    IEN          Long Cross Reference Deleted"
 S PSLINE=PSLINE+1
 S A(PSLINE)="    ------------ ---------------------------------------------"
 S PSLINE=PSLINE+1
 S A(PSLINE)="                      Truncated Cross Reference Set"
 S PSLINE=PSLINE+1
 S A(PSLINE)="                      ------------------------------"
 D STR
 Q
 ;
STR ;set data in mail message array
 S PSLINE=PSLINE+1
 S A(PSLINE)=" "
 S PSSUB=""
 F  S PSSUB=$O(^XTMP("PSSP194",PSSEQ,PSSUB)) Q:PSSUB=""  D
 . S PSSTR=^XTMP("PSSP194",PSSEQ,PSSUB),PSSIEN=$P(PSSTR,"^"),PSSNAME=$P(PSSTR,"^",2),PSSCROSS=$P(PSSTR,"^",3)
 . S PSLINE=PSLINE+1
 . S A(PSLINE)="    "_PSSIEN_$E(PSSPACE,1,14-$L(PSSIEN))_$S(PSSNAME]"":PSSNAME,1:"No name on entry")
 . S PSLINE=PSLINE+1
 . S A(PSLINE)="                      "_$S(PSSCROSS]"":PSSCROSS,1:"None -- no name on entry")
 Q
 ;
