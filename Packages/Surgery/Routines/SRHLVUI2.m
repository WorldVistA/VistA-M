SRHLVUI2 ;B'ham ISC/DLR - Surgery Interface Con. Utility to process incoming segments ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;;This routine utilizes the Surgery Interface file (133.2).
NTE(NTE,OBR) ;process NTE-3
 ;anesthesia comments
 ;find the entry for this technique
 N FILE,FIELD,IENS,FLAGS,WP,X,Y
 N CASE S CASE=$P(OBR,HLFS,4) Q:CASE=""
 S DIC="^SRF("_CASE_",6,",DIC(0)="OSXZ",X=$P($P(OBR,HLFS,5),HLCOMP,5) D ^DIC Q:Y<0
 S FILE=130.06,FIELD=40,IENS=+Y_","_CASE_",",FLAGS="A",WP(1)=$P(NTE,HLFS,4) D WP^DIE(FILE,IENS,FIELD,FLAGS,"WP","SRE")
 Q
OBX(OBX,OBR) ;process Observation Segment (OBX) fields 3,5,14,16
 ;
 N SRUPD,VALUE,CHKV,SROUT
 S ID=$P($P(OBX,HLFS,4),HLCOMP,2) I $G(ID)="" S HLERR="Missing Identifier with "_$P(OBX,HLFS)_" "_$P(OBX,HLFS,2) D ERR^SRHLVUI(OBX,IEN) Q
 S IEN=$O(^SRO(133.2,"AC",ID,0)) I $G(IEN)="" D SET^SRHLVORU("Invalid OBX identifier, "_ID_", ",OBR,OBX,.SRHLX) Q
 ;if field is set to receive, then set DR string for DIE call
 I $$CHECK^SRHLVUI(IEN)=1 D
 .I '$D(^SRO(133.2,IEN,1,0)) S VALUE=$$VALUE^SRHLVUI(IEN) D:VALUE=""  I "^"'[$$CHKV^SRHLVUI(IEN,VALUE) S LVL=$P(^SRO(133.2,IEN,0),U,9) D DR^SRHLVUI(LVL,IEN) S UPDATE=1
 ..;create discrepancy message entry for null or invalid entries
 ..N TEXT S TEXT="Invalid value, "_$P($P(OBX,HLFS,6),HLCOMP,1,3)_$S($P(^SRO(133.2,IEN,0),U,11)'="":" for File #"_$P($P(^SRO(133.2,IEN,0),U,11),"99VA",2),1:"") D SET^SRHLVORU(TEXT,OBR,$G(OBX),.SRHLX)
 .;process multiple field segments, ex. replacement fluids
 .;SRUPD is used to update multiple field entries that are not multiples, ex. TOURNIQUET APPLIED.  If the entry is not a multiple SRUPD is set to 0.
 .I $D(^SRO(133.2,IEN,1,0)) S SRUPD=1,SRX=0 F  S SRX=$O(^SRO(133.2,IEN,1,SRX)) Q:'SRX!($D(HLERR))!($G(SROUT)=1)  S LVL=$P(^SRO(133.2,SRX,0),U,9) Q:"123"[$G(LVL)&($G(LVL)="")  D:$$CHECK^SRHLVUI(SRX)=1
 ..S CHKV=$$CHKV^SRHLVUI(SRX,$$VALUE^SRHLVUI(SRX)) D
 ...I CHKV'="^" D DR^SRHLVUI(LVL,SRX) I $P(^SRO(133.2,SRX,0),U,3)=.01 S UPDATE=1 S LVL=$P(^SRO(133.2,IEN,0),U,9) D DR^SRHLVUI(LVL,IEN) S SRUPD=0
 ...I CHKV="^" I $P(^SRO(133.2,SRX,0),U,3)=.01 S SROUT=1
 .;if SRUPD = 1 a non-multiple was processed, so update original IEN
 .I $D(^SRO(133.2,IEN,1,0))&($G(SRUPD)=1) S LVL=$P(^SRO(133.2,IEN,0),U,9) D DR^SRHLVUI(LVL,IEN)
 Q
