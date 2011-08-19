LR7OVB ;HOIFO/BNT - Lab Receive HL7 Order Update from VBECS ;2/22/08  21:19
 ;;5.2;LAB SERVICE;**367**;Sep 27, 1994;Build 12
 ;Reference to $$FIND1^DIC supported by IA #2051
 ;Reference to EN^ORMVBEC supported by IA #4982
 ;Reference to $$HL7TFM^XLFDT supported by IA #10103
 ;Reference to $$NOW^XLFDT supported by IA #10103
 ;Reference to $$STRIP^XLFSTR supported by IA #10104
 ;
EN1(LRMSG) ; Entry point for LR7O VBECS RECEIVE Protocol
 N LRSEG,LRSEGID,LRERR,LRACK,ORDCNTRL,LROIEN,LRTST,LRDFN,DFN,LRI,LRJ,ORIFN,ORDSTS,ORDCNTRL
 S LRQUIT=0
 S LRI=0 F  S LRI=$O(LRMSG(LRI)) Q:'LRI  D  Q:$D(LRERR)!(LRQUIT)
 . S LRSEG=LRMSG(LRI),LRSEGID=$P(LRMSG(LRI),HL("FS"))
 . I $T(@LRSEGID)]"" D @LRSEGID
 Q:$D(LRERR)!(LRQUIT)
 ;
 I 'LRACK D GENACK
 Q
 ;
ORC ; - Process ORC segment
 S ORDCNTRL=$TR($P(LRSEG,HL("FS"),2),"@","P")
 I '$L(ORDCNTRL) S LRERR="Invalid control code" D ERROR Q
 S ORDSTS=$P(LRSEG,HL("FS"),6)
 I ORDSTS'="CM" D ERROR Q
 Q
 ;
OBR ; -- Process OBR segment
 S LROIEN=$P($P(LRSEG,HL("FS"),14),";")
 S LRTST=$$STRIP^XLFSTR($P($P(LRSEG,HL("FS"),14),";",4)," ")
 I LRTST']"" S LRERR="Missing Lab Test ID" D ERROR Q
 I LROIEN']"" S LRERR="Missing Lab Test IEN" D ERROR Q
 ; Complete the Lab Order
 D COMPLETE(LROIEN,LRTST,LRDFN1)
 Q
 ;
PID ; -- Process PID segment
 N I,X,PIDLST
 ; Adding logic to support v2.4 Patient Id List
 S PIDLST=$P(LRSEG,HL("FS"),4)
 I PIDLST[$E(HL("ECH")) D
 . F I=1:1:$L(PIDLST,$E(HL("ECH"),2)) S X=$P(PIDLST,$E(HL("ECH"),2),I) Q:X=""  I $P(X,$E(HL("ECH")),5)["PI" S LRDFN1=+X Q
 I PIDLST'[$E(HL("ECH")) S LRDFN1=+$P(LRSEG,HL("FS"),4)
 I '$D(^DPT(LRDFN1,0)) S LRERR="Invalid Patient Id "_LRDFN1 D ERROR Q
 Q
 ;
FMDATE(Y) ; -- Convert HL7 date/time to FM format
 Q $$HL7TFM^XLFDT(Y)  ;**97
 ;
ERROR ;
 S LRQUIT=1
 I 'LRACK D GENACK
 Q
 ;
COMPLETE(LROIEN,LRTST,LRDFN1) ; - Complete the accession for this test and the OERR order
 ; LROIEN = File 69 IEN
 ; LRTST = File 60 IEN
 ; LRDFN1 = File 2 IEN
 N LRA,LRB,LRC,LR0,LRV,LRAA,LRY,LRAD,LRAN,LRODT,LRSN
 S (LRQUIT,LRW)=0
 I '$D(LRACK) S LRACK=1
 I '$D(^LRO(69,"C",LROIEN)) S LRERR="Invalid Lab Order Number" D ERROR Q
 S LRA=0 F  S LRA=$O(^LRO(69,"C",LROIEN,LRA)) Q:'LRA  D  Q:LRQUIT
 . S LRB=0 F  S LRB=$O(^LRO(69,"C",LROIEN,LRA,LRB)) Q:'LRB  D
 . . ; Order has been merged.
 . . I $P($G(^LRO(69,LRA,1,LRB,1)),"^",7)]"" D ERROR Q
 . . S LRC=0 F  S LRC=$O(^LRO(69,LRA,1,LRB,2,LRC)) Q:'LRC  D
 . . . S LR0=^LRO(69,LRA,1,LRB,2,LRC,0) Q:+LR0'=LRTST
 . . . S LRDFN=$P(^LRO(69,LRA,1,LRB,0),"^",1)
 . . . I $P($G(^LR(LRDFN,0)),"^",3)'=LRDFN1 S LRERR="Lab Patient on order does not match patient DFN" D ERROR Q
 . . . S LRAA=$P($G(LR0),"^",4)
 . . . S LRAD=$P($G(LR0),"^",3)
 . . . S LRAN=$P($G(LR0),"^",5)
 . . . S ORIFN=$P($G(LR0),"^",7)
 . . . S LRK=$$NOW^XLFDT()
 . . . I '$$FIND1^DIC(68.04,","_LRAN_","_LRAD_","_LRAA_",","QUX",LRTST,,,"LRERR") Q  ;Test not ordered or not accession. Same action either way.
 . . . S LRV=$$GET1^DIQ(68.04,LRTST_","_LRAN_","_LRAD_","_LRAA_",",4,"I",,"LRERR") Q:LRV  ;Already complete
 . . . S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0)
 . . . S LRSVC=$P(X,"^",9)
 . . . S LRLLOC=$P(X,"^",7)
 . . . S LRDFN=+X Q:'$D(^LR(LRDFN,0))
 . . . S LRODT=$P(X,"^",4)
 . . . S LRSN=$P(X,"^",5)
 . . . ;S LRLABPOC=$$FIND1^DIC(200,,"BOX","LRLAB,POC",,,"ERR") S:'LRLABPOC LRLABPOC=".5"
 . . . K DIERR,LRFDA D FDA^DILF(68.04,LRTST_","_LRAN_","_LRAD_","_LRAA_",",4,,LRK,"LRFDA")
 . . . D FDA^DILF(68.04,LRTST_","_LRAN_","_LRAD_","_LRAA_",",3,,"LRLAB,POC","LRFDA")
 . . . D FILE^DIE("E","LRFDA","LRERR")
 . . . S Y=^LRO(68,LRAA,1,LRAD,1,LRAN,0),Y(4)=$P(Y,"^",4),Y(5)=$P(Y,"^",5)
 . . . ;Y(4)=Date Ordered, Y(5)=Specimen Number
 . . . I Y(4),Y(5),$D(^LRO(69,Y(4),1,Y(5),3)) K DIERR,LRFDA D FDA^DILF(69.01,Y(5)_","_Y(4)_",",21,,LRK,"LRFDA") Q:$D(DIERR)  D FILE^DIE("E","LRFDA","LRERR")
 . . . S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTST,1,0)) ^(0)="^68.14P^^"
 . . . S ORDCNTRL="SC",ORDSTS="CM"
 . . . D EN^ORMVBEC
 . . . Q
 ;
 Q
 ;
GENACK ; -- Send an acknowldegement to original message
 ;Q:$G(VBTEST)
 S MSA1="AA"
 I $D(LRERR) S MSA1="AR"
 S HLA("HLA",1)="MSA"_HL("FS")_MSA1_HL("FS")_HL("MID")_$S($D(LRERR):HL("FS")_LRERR,1:"")
 S HLEID=HL("EID"),HLEIDS=HL("EIDS")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.RESULT)
 K MSA
 Q
