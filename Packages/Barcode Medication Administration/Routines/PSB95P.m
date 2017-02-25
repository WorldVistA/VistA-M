PSB95P ;ASMR/hrubovcak - post-install for PSB patch 95 ;Jun 13, 2016 14:29:16
 ;;3.0;BAR CODE MED ADMIN;**95**;13 June 2016;Build 10
 ;
 ; fix for DE4250: modify PS EVSEND OR extended action protocol
 ; set sequence numbers for PSB BCBU RECEIVE and HMP XQOR EVENTS
 Q
 ;
EN ;
 D DT^DICRW,MES^XPDUTL("updating PS EVSEND OR protocol")
 N DIC,G,ITM,J,PSBFMSG,PSBORIG,SEQMX,X,Y
 S DIC=101,X="PS EVSEND OR",DIC(0)="Z" D ^DIC  ; find PS EVSEND OR
 ; target protocol not found, write message, exit
 I '(Y>0) D  Q
 . D MES^XPDUTL("*ERROR*: PS EVSEND OR protocol not found!")
 . D MES^XPDUTL("IRM support staff should contact eHMP or BCMA development.")
 ;
 ; IEN for PS EVSEND OR is +Y
 D GETS^DIQ(101,(+Y)_",","**","EN","PSBORIG","PSBFMSG")  ; external format, skip null values
 I $D(PSBFMSG("DIERR")) D  Q  ; list FileMan error, exit
 . W !," FileMan error, retrieving ITEM values." S G="PSBFMSG(""DIERR"")"
 . F  S G=$Q(@G) Q:'(G["DIERR")  D MES^XPDUTL(G_" = "_@G)
 . D MES^XPDUTL($T(+0)_" post-init exited prematurely")
 ;
 S ITM("1ST")="HMP XQOR EVENTS",ITM("2ND")="PSB BCBU RECEIVE"  ; ITEM targets
 S (ITM("1ST","IENS"),ITM("2ND","IENS"))=""  ; IENS for target ITEM entries
 S SEQMX=0  ; SEQUENCE maximum
 ; iterate through results, find target items
 S Y="" F  S Y=$O(PSBORIG(101.01,Y)) Q:Y=""  D
 . S X=+$G(PSBORIG(101.01,Y,3,"E")) S:X>SEQMX SEQMX=X  ; highest SEQUENCE value
 . S X=$G(PSBORIG(101.01,Y,.01,"E"))
 . F J="1ST","2ND" S:X=ITM(J) ITM(J,"IENS")=Y  ; target IEN
 ;
 I (ITM("1ST","IENS")="")!(ITM("2ND","IENS")="") D  Q  ; must have IEN for both targets
 . D MES^XPDUTL("missing IEN for target item(s)")
 . F J="1ST","2ND" I ITM(J,"IENS")="" D MES^XPDUTL("IEN for "_ITM(J)_" not found.")
 . D MES^XPDUTL("No update made by "_$T(+0)_" post-init")
 ;
 ; if both ITEM entries have SEQUENCE numbers, and the 2nd is greater than the 1st, no action needed
 K Y F J="1ST","2ND" S Y(J)=$G(PSBORIG(101.01,ITM(J,"IENS"),3,"E"))
 I Y("1ST"),Y("2ND"),Y("2ND")>Y("1ST") D  Q
 . D MES^XPDUTL("No SEQUENCE update needed."),MES^XPDUTL("No action taken by "_$T(+0)_" post-init.")
 ;
 F J="1ST","2ND" D  ; update the ITEM sequence
 . N PSBFDA K PSBFMSG  ; KILL old FileMan message array each time
 . S SEQMX=SEQMX+10  ; add 10 to sequence maximum
 . S PSBFDA(101.01,ITM(J,"IENS"),3)=SEQMX  ; SEQUENCE field (#3)
 . D UPDATE^DIE("","PSBFDA","","PSBFMSG")
 . I $D(PSBFMSG("DIERR")) D
 ..  W !," FileMan error, updating SEQUENCE values" S G="PSBFMSG(""DIERR"")"
 ..  F  S G=$Q(@G) Q:'(G["DIERR")  D MES^XPDUTL(G_" = "_@G)
 ;
 D BMES^XPDUTL($T(+0)_" post-init completed "_$$HTE^XLFDT($H))
 ;
 Q
 ;
