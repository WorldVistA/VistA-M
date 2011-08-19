RA94PST  ;Hines OI/GJC - Post-init Driver, patch 94 ;07/24/08  12:13
 ;;5.0;Radiology/Nuclear Medicine;**94**;Mar 16, 1998;Build 9
 ;
NEW1AD ;Check to see if the traditional "AD" cross-reference was deleted.
 ;If not, delete the traditional "AD" cross-reference. Check to see if
 ;the new style "AD" cross-reference exists. If it does, delete it and 
 ;re-create it while re-indexing the data. If the new style "AD" does not
 ;exist, create it while re-indexing the data.
 ;
 ;Tag^Routine                Integration Agreement
 ;------------------------------------------------
 ;^%ZTLOAD                           10063
 ;CREIXN/DELIX/DELIXN^DDMOD           2916
 ;$$FIND1^DIC                         2051
 ;$$GET1^DIQ(2056)
 ;$$FMADD/$$NOW^XLFDT                10103 
 ;^XMD                               10070                   
 ;$$GOTLOCAL^XMXAPIG                  3006
 ;MES^XPDUTL                         10141
 ;$$KSP^XUPARAM(2541)
 ;
 N DIERR,RAERR,RANODE,RATXT,RAVALUE,RAXIT,RAY
 ;
 ;In order to create the new style "AD" cross-reference & re-index the data
 ;the traditional "AD" cross-reference has to be deleted.
 ;
 ; -----------------------------------------------------------
 ;| Deleting of the "AD" cross-reference from '^DD(70.03,13,' |
 ;| will also cause the "AD" cross-reference to be deleted.   |
 ; -----------------------------------------------------------
 ;
 ;^DD(70.03,13,1,n,0)=definition ex: 70^AD^MUMPS
 ;^DD(70.03,13,1,n,1)=set logic
 ;^DD(70.03,13,1,n,2)=kill logic
 ;^DD(70.03,13,1,n,3)=no-deletion message
 ;^DD(70.03,13,1,n,"%D",x,0)=description of cross-reference
 ;Where 'n' is the cross-reference instance
 ;Where 'x' is the description line instance
 ;
 S RANODE=$NA(^DD(70.03,13,1)),(RAXIT,RAY)=0
 F  S RAY=$O(@RANODE@(RAY)) Q:'RAY  Q:$G(@RANODE@(RAY,0))="70^AD^MUMPS" 
 ;
 I RAY>0 D  ;there is a traditional "AD" cross-reference to delete
 .D DELIX^DDMOD(70.03,13,RAY,"K","","RAERR") ;"K" delete the cross-referenced data
 .I $D(RAERR("DIERR"))#2 S RAXIT=1 D
 ..S RATXT(1)="Error when attempting to delete the traditional ""AD"" cross-reference."
 ..S RATXT(2)="Field name: PRIMARY DIAGNOSTIC CODE, data dictionary: 70.03, field #: 13" Q
 .E  S RATXT(1)="The traditional ""AD"" cross-reference has been deleted."
 .S RATXT($O(RATXT($C(32)),-1)+1)="" D MES^XPDUTL(.RATXT) Q
 ;
 ;<<< If there was a traditional "AD" cross-reference to delete was it deleted (RAXIT=0)? >>>
 ;
 I RAXIT K RATXT D  Q  ;cannot continue until the old "AD" is deleted
 .S RATXT(1)="The new style ""AD"" cross-reference cannot be created until"
 .S RATXT(2)="the traditional ""AD"" cross-reference is deleted."
 .D MES^XPDUTL(.RATXT) Q
 ;
 ; ------------------------------------------------------------
 ;| Check to see if the new style "AD" cross-reference exists. |
 ;| If it does delete the new style "AD" cross-reference.      |
 ;|                                                            |
 ;| Then re-create the new style "AD" cross-reference while    |
 ;| cross-referencing the data.
 ; ------------------------------------------------------------
 ;
 S RAVALUE(1)=70,RAVALUE(2)="AD"
 ;Note: "BB" (5th subscript) is the FILE & NAME cross-reference index in the INDEX (#.11) file.
 ;he third subscript "X"
 S RAY=$$FIND1^DIC(.11,"","X",.RAVALUE,"BB","","RAERR")
 ;
 I RAY K RATXT D  ;found a match
 .S RATXT(1)="The 'New Style' PRIMARY DIAGNOSTIC CODE (70.03, #13) ""AD"""
 .S RATXT(2)="is currently in existence. We will rebuild and re-index the"
 .S RATXT(3)="""AD"" cross-reference.",RATXT($O(RATXT($C(32)),-1)+1)=""
 .D MES^XPDUTL(.RATXT)
 .D DELIXN^DDMOD(70.03,"AD","K") ;delete the prior instance and the data indexed
 .Q
 ;
 ;-----------------------------------------------------
 ;
 I RAY="" K RATXT D  Q  ;error on lookup
 .S RATXT=$G(RAERR("DIERR","1","TEXT",1))
 .S RATXT(1)="Error determining if the new style PRIMARY DIAGNOSTIC CODE (70.03, #13) ""AD"""
 .S RATXT(2)="cross-reference exists. This error prohibits us from moving forward."
 .S:$G(RAERR("DIERR","1","TEXT",1))'="" RATXT(3)=$G(RAERR("DIERR","1","TEXT",1))
 .D MES^XPDUTL(.RATXT) Q
 ;
 ;-----------------------------------------------------
 ;
 ;There are two possible realities at this point. One is that the new style "AD"
 ;cross-reference did exist (RAY>0) in which case we proceeded to delete that
 ;instance of the new style "AD" and now move to rebuilt and re-index the index.
 ;
 ;Or, the new style "AD" cross-reference never did exist (RAY=0). In this case, we
 ;create the new style "AD" cross-reference and rebuild the "AD" cross-reference.
 ;
 ;In either case, due to the length of time to re-index, the process is tasked off
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK S ZTRTN="CREIXN^RA94PST",ZTIO=""
 S ZTDTH=$$FMADD^XLFDT($E($$NOW^XLFDT(),1,12),0,0,1,0) ;start task in one minute...
 S ZTDESC="RA94PST, the post-install process for RA*5.0*94, rebuilds the ""AD"" xref on the PRIMARY DIAGNOSTIC CODE (70.03 - 0;13) field."
 D ^%ZTLOAD K RATXT S RATXT(1)=""
 I $D(ZTSK)#2[0 S RATXT(2)="Task Cancelled"
 E  S RATXT(2)="Task: "_$G(ZTSK)_" queued..."
 D MES^XPDUTL(.RATXT) Q
 ;
 ;
CREIXN ;rebuilds the ""AD"" xref on the PRIMARY DIAGNOSTIC CODE (70.03 - 0;13) field
 ;Note: this is a background process created by ^%ZTLOAD.
 N RARSLT,RAXREF K DIERR,RAERR,RATXT
 S RAXREF("FILE")=70,RAXREF("TYPE")="MU",RAXREF("NAME")="AD"
 S RAXREF("EXECUTION")="F",RAXREF("ROOT FILE")=70.03,RAXREF("USE")="S"
 S RAXREF("ACTIVITY")="IR"
 S RAXREF("SHORT DESCR")="The 'AD' is used to mark cases eligible for the Abnormal Report option."
 S RAXREF("DESCR",1)="If the diagnostic code record in the radiology DIAGNOSTIC CODES (#78.3)"
 S RAXREF("DESCR",2)="has the data attribute for field: PRINT ON ABNORMAL REPORT (#3) set to"
 S RAXREF("DESCR",3)="'Y' (yes) then the ""AD"" cross-reference will be set for this exam record"
 S RAXREF("DESCR",4)="to indicate that this case should be identified on the Abnormal Report."
 S RAXREF("DESCR",5)=""
 S RAXREF("DESCR",6)="NOTE: When this field is edited the DIAGNOSTIC PRINT DATE (#20) field is"
 S RAXREF("DESCR",7)="deleted!",RAXREF("VAL",1)=13
 S RAXREF("KILL CONDITION")="S:X1(1)'="""" X=1"
 S RAXREF("KILL")="D:($D(X1(1))#2) PRIDXIXK^RADD2(.DA,X1(1))"
 S RAXREF("SET CONDITION")="S:X2(1)'="""" X=1"
 S RAXREF("SET")="S:$P($G(^RA(78.3,X2(1),0)),U,3)=""Y"" ^RADPT(""AD"",X2(1),DA(2),DA(1),DA)="""""
 ;S RAXREF("WHOLE KILL")="K ^RADPT(""AD"")" Note: no re-indexing is to occur.
 ;
 ;D CREIXN^DDMOD(.RAXREF,"S",.RARSLT,"","RAERR") ;"S" (2nd parameter) means the "AD" is rebuilt
 D CREIXN^DDMOD(.RAXREF,"",.RARSLT,"","RAERR") ;the 2nd input param is null; no re-indexing
 ;
BLDMSG ;failure: we did not create the cross-reference
 I RARSLT=""!($D(RAERR("DIERR"))#2) D
 .S RATXT(1)="Facility: "_$$GET1^DIQ(4,+$$KSP^XUPARAM("INST"),.01),RATXT(2)=""
 .S RATXT(3)="Error when attempting to delete the new style ""AD"" cross-reference."
 .S RATXT(4)="Field name: PRIMARY DIAGNOSTIC CODE, data dictionary: 70.03, field #: 13"
 .S RATXT(5)=$G(RAERR("DIERR",1,"TEXT",1))
 .N RAIRM S RAIRM="Contact your local IRM support staff."
 .I RATXT(5)="" S RATXT(6)=RAIRM
 .E  S RATXT(6)="",RATXT(7)=RAIRM
 .Q
 ;
 E  S ZTREQ="@"
 ;
 Q:'$O(RATXT(0))  ;no news is good news...
 ;
MAIL ; pass the negative results concerning the tasked process
 ;(rebuilding the "AD" xref) to the user via VA MailMan
 N %,D0,D1,D2,DG,DIC,DICR,DIW,XMDUN,XMDUZ,XMSUB,XMTEXT,XMY
 S XMDUZ=.5,XMTEXT="RATXT("
 S XMSUB="RA*5.0*94: results of rebuilding the ""AD"" cross-reference"
 I '$$GOTLOCAL^XMXAPIG("G.RAD HL7 MESSAGES") D
 .S XMY(DUZ)=""
 E  S XMY("G.RAD HL7 MESSAGES")=""
 S XMY("VAOITVHITRadDevIssues@va.gov")="" ;to me...
 D ^XMD Q
 ;
