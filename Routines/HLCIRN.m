HLCIRN ;SFISC/RJH-Don't Purge and Reprocessing message   ;07/28/97  10:14
 ;;1.6;HEALTH LEVEL SEVEN;**33**;Oct 13, 1995
 Q
 ;
DONTPURG() ; set the DONT PURGE field to 1 in order to prevent the message
 ; from purging.
 ; return value :  1 for successfully set the field
 ;                -1 for failure
 ;
 N FLAG
 S FLAG=$$SETPURG(1)
 Q FLAG
 ;
TOPURG() ; clear the DONT PURGE field to allow the message to be purged.
 ; return value :  0 for successfully clear the field
 ;                -1 for failure
 ;
 N FLAG
 S FLAG=$$SETPURG(0)
 Q FLAG
 ;
SETPURG(STATUS) ; to set or to clear the DONT PURGE field
 ; at least one of the variables, HLMTIEN and HLMTIENS, must be defined
 ; HLMTIEN- parent message IEN
 ; HLMTIENS- child message IEN
 ; input: 1 to set the DONT PURGE field
 ;        0 to clear the DONT PURGE field.
 ; return value: 1 means successfully set the DONT PURGE field
 ;               0 means successfully clear the DONT PURGE field
 ;              -1 means fail to set or to clear the field
 ;
 N FLAG
 S FLAG=""
 I (STATUS'=1)&(STATUS'=0) Q -1
 I '$G(HLMTIEN),'$G(HLMTIENS) Q -1
 ;
 ; both HLMTIEN and HLMTIENS are defined
 I $G(HLMTIEN),$G(HLMTIENS) D
 . I '$D(^HL(772,HLMTIEN)) S FLAG=-1 Q
 . I '$D(^HL(772,HLMTIENS)) S FLAG=-1 Q
 . I (HLMTIEN'=$P(^HL(772,HLMTIENS,0),"^",8)) S FLAG=-1 Q
 . D SETVALUE
 . S FLAG=STATUS
 I (FLAG=-1)!(FLAG=STATUS) Q FLAG
 ;
 ; only HLMTIEN(parent message IEN) is defined
 I $G(HLMTIEN) D
 . I '$D(^HL(772,HLMTIEN)) S FLAG=-1 Q
 . I (HLMTIEN'=$P(^HL(772,HLMTIEN,0),"^",8)) S FLAG=-1 Q
 . D SETVALUE
 . S FLAG=STATUS
 I (FLAG=-1)!(FLAG=STATUS) Q FLAG
 ;
 ; only HLMTIENS(child message IEN) is defined
 I $G(HLMTIENS) D
 . I '$D(^HL(772,HLMTIENS)) S FLAG=-1 Q
 . S HLMTIEN=$P(^HL(772,HLMTIENS,0),"^",8)
 . I 'HLMTIEN S FLAG=-1 Q
 . I '$D(^HL(772,HLMTIEN)) S FLAG=-1 Q
 . I (HLMTIEN'=$P(^HL(772,HLMTIEN,0),"^",8)) S FLAG=-1 Q
 . D SETVALUE
 . S FLAG=STATUS
 Q FLAG
 ;
SETVALUE ; set or clear the DONT PURGE field
 L +^HL(772,HLMTIEN)
 S ^HL(772,HLMTIEN,2)=STATUS
 I $G(HLMTIENS) S ^HL(772,HLMTIENS,2)=STATUS
 L -^HL(772,HLMTIEN)
 Q
 ;
REPROC(IEN,RTN) ; reprocessing message
 ; IEN- either the parent message IEN or the child message IEN
 ; RTN- the routine, to be Xecuted for processing the message
 ; return value:  0 for success, -1 for failure
 ;
 N HLMTIEN,HLMTIENS,HLNEXT,HLNODE,HLQUIT,HLERR,HLRESLT
 N HL,HDR,FS,ECH,HLMSA,X,X1,X2
 S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 S HLMSA=""
 I '$G(IEN) Q -1
 I '$D(^HL(772,IEN)) Q -1
 I $G(RTN)'["" Q -1
 S HLMTIEN=$P(^HL(772,IEN,0),"^",8)
 Q:'HLMTIEN -1
 I HLMTIEN'=IEN S HLMTIENS=IEN
 ;
 S X=0
 F  S X=$O(^HL(772,HLMTIEN,"IN",X)) Q:X'>0  D
 .  S X1=$G(^HL(772,HLMTIEN,"IN",X,0))
 .  Q:"FHS,BHS,MSH,MSA"'[$E(X1,1,3)
 .  ; If header segment, process it and set HDR equal to it
 .  I '$D(HDR),"FHS,BHS,MSH"[$E(X1,1,3) D
 ..   S HDR=X1
 ..   S (HL("FS"),FS)=$E(HDR,4)
 ..   S (HL("ECH"),ECH)=$P(HDR,FS,2)
 ..   S $P(HDR,FS,8)=""
 ..   I "FHS,BHS"[$E(HDR,1,3) D
 ...    S HL("DTM")=$P(HDR,FS,7)
 ...    S HL("MID")=$P(HDR,FS,11)
 ...    S X2=$P(HDR,FS,9)
 ...    S HL("PID")=$P(X2,$E(ECH),2)
 ...    S HL("MTN")=$P($P(X2,$E(ECH),3),$E(ECH,4))
 ...    S HL("ETN")=$P($P(X2,$E(ECH),3),$E(ECH,4),2)
 ...    S HL("VER")=$P(X2,$E(ECH),4)
 ...    I $P(HDR,FS,10)]"" S HLMSA="MSA"_FS_$P($P(HDR,FS,10),$E(HDR,5),1)_FS_$P(HDR,FS,12)_FS_$P($P(HDR,FS,10),$E(HDR,5),2)
 ..   I $E(HDR,1,3)="MSH" D
 ...    S HL("DTM")=$P(HDR,FS,7)
 ...    S HL("MID")=$P(HDR,FS,10)
 ...    S HL("PID")=$P(HDR,FS,11)
 ...    S HL("MTN")=$P($P(HDR,FS,9),$E(ECH))
 ...    S HL("ETN")=$P($P(HDR,FS,9),$E(ECH),2)
 ...    S HL("VER")=$P(HDR,FS,12)
 ...    S:$P(HDR,FS,15)]"" HL("ACAT")=$P(HDR,FS,15)
 ...    S:$P(HDR,FS,16)]"" HL("APAT")=$P(HDR,FS,16)
 ...    S:$P(HDR,FS,17)]"" HL("CC")=$P(HDR,FS,17)
 .  ; If acknowledgement segment, set MSA equal to it
 .  I $E(X1,1,3)="MSA",$G(HLMSA)="",$E($G(HDR),1,3)="MSH" S HLMSA=X1
 Q:'$D(HDR) -1
 ;
 I RTN["D " X RTN
 I RTN'["D " D
 . I RTN["^" X "D "_RTN
 . I RTN'["^" X "D ^"_RTN
 S HLRESLT=0 S:($D(HLERR)) HLRESLT="9^"_$G(^HL(771.7,9,0))
 ; update the status of child message
 I $G(HLMTIENS) D STATUS^HLTF0(HLMTIENS,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S($D(HLERR):HLERR,HLRESLT:$P(HLRESLT,"^",2),1:""))
 ; update the status of parent message
 D STATUS^HLTF0(HLMTIEN,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S(HLRESLT:$P(HLRESLT,"^",2),1:""))
 Q 0
