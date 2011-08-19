LR7OB630 ;slc/dcm - Get Lab data from 63 only ;8/11/97
 ;;5.2;LAB SERVICE;**121**;Sep 27, 1994
EN(LABPAT,SS,IDT) ;Get data from 63
 ;LABPAT=Lab Patient ID
 ;SS=Subscript CH, MI, EM, CY, AU, SP, BB
 ;IDT=Inverse D/T verified
 Q:'$G(LABPAT)!('$G(IDT))!('$L($G(SS)))
 N GOTCOM
 I $L($T(@SS)) G @SS
 Q
CH ;Chem, Hem, Tox, Ria, Ser, etc.
 N Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,ACC,AC,ACD,ACN,X,X0
 Q:'$D(^LR(LABPAT,SS,IDT))  S X0=^(IDT,0)
 D DFN
 S (AC,Y1,Y3,Y4,Y11)="",Y2=+X0,Y5=+X0,Y6="",Y7=$P(X0,"^",11),Y8=+X0,Y9=$P(X0,"^",3),Y10=$P(X0,"^",5),Y12=$P(X0,"^",4),ACC=$P(X0,"^",6)
 I $L(ACC) S X=$P(ACC," "),X=$O(^LRO(68,"B",X,0)) I X S AC=X,ACD=+$P(X0,"."),ACN=$P(ACC," ",3) S:'$D(^LRO(68,AC,1,ACD,1,ACN)) AC=""
 I AC D 68 Q
 D 69,63^LR7OB63(1,LRDFN,SS,IDT)
 Q
MI ;Microbiology
 N Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,ACC,AC,ACD,ACN,X,X0
 Q:'$D(^LR(LABPAT,SS,IDT))  S X0=^(IDT,0)
 D DFN
 S (AC,Y1,Y4,Y5,Y11)="",Y2=+X0,Y3=$P(X0,"^",11),Y6=$P(X0,"^",7),Y7=$P(X0,"^",8),Y8=$P(X0,"^",10),Y9=$P(X0,"^",3),Y10=$P(X0,"^",5),Y12=$P(X0,"^",4),ACC=$P(X0,"^",6)
 I $L(ACC) S X=$P(ACC," "),X=$O(^LRO(68,"B",X,0)) I X S AC=X,ACD=+$P(X0,"."),ACN=$P(ACC," ",3) S:'$D(^LRO(68,AC,1,ACD,1,ACN)) AC=""
 I AC D 68 Q
 D 69,63^LR7OB63(1,LRDFN,SS,IDT)
 Q
BB ;Blood bank
 N Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,ACC,AC,ACD,ACN,X,X0
 Q:'$D(^LR(LABPAT,SS,IDT))  S X0=^(IDT,0)
 D DFN
 S (AC,Y1,Y4,Y5,Y11)="",Y2=+X0,Y3=$P(X0,"^",11),Y6=$P(X0,"^",7),Y7=$P(X0,"^",4),Y8=$P(X0,"^",10),Y9=$P(X0,"^",3),Y10=$P(X0,"^",5),Y12=$P(X0,"^",4),ACC=$P(X0,"^",6)
 I $L(ACC) S X=$P(ACC," "),X=$O(^LRO(68,"B",X,0)) I X S AC=X,ACD=+$P(X0,"."),ACN=$P(ACC," ",3) S:'$D(^LRO(68,AC,1,ACD,1,ACN)) AC=""
 I AC D 68 Q
 D 69,63^LR7OB63(1,LRDFN,SS,IDT)
 Q
EM ;Electron Microscopy
 G CY
SP ;Surgical Pathology
 G CY
CY ;Cytology
 N Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,ACC,AC,ACD,ACN,X,X0
 Q:'$D(^LR(LABPAT,SS,IDT))  S X0=^(IDT,0)
 D DFN
 S (AC,Y1,Y3,Y4,Y5,Y10,Y11)="",Y2=+X0,Y6=$P(X0,"^",7),Y7=$P(X0,"^",8),Y8=$P(X0,"^",10),Y9=$P(X0,"^",3),Y12=$P(X0,"^",4),ACC=$P(X0,"^",6)
 I $L(ACC) S X=$P(ACC," "),X=$O(^LRO(68,"B",X,0)) I X S AC=X,ACD=+$P(X0,"."),ACN=$P(ACC," ",3) S:'$D(^LRO(68,AC,1,ACD,1,ACN)) AC=""
 I AC D 68 Q
 D 69,63^LR7OB63(1,LRDFN,SS,IDT)
 Q
AU ;Autopsy
 N X,X0,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12
 Q:'$D(^LR(LABPAT,SS))  S X0=^(SS)
 D DFN
 S (Y1,Y3,Y4,Y5,Y8,Y10,Y11,Y12)="",Y2=+X0,Y6=$P(X0,"^",12),Y7=$P(X0,"^",5),Y9=$P(X0,"^",3)
 D 69,63^LR7OB63(1,LRDFN,SS)
 Q
DFN ;Get patient stuff
 S:'$D(DFN) DFN=$P(^LR(LABPAT,0),"^",3) S:'$D(LRDFN) LRDFN=LABPAT S:'$D(LRDPF) LRDPF=$P(^LR(LABPAT,0),"^",2)_$G(^DIC(+$P(^LR(LABPAT,0),"^",2),0,"GL"))
 Q
69 ;Set lrx(69
 S ^TMP("LRX",$J,69)=Y1_"^"_Y2_"^"_Y3_"^"_Y4_"^"_Y5_"^"_Y6_"^"_Y7_"^"_Y8_"^"_Y9_"^"_Y10_"^"_Y11_"^"_Y12,^TMP("LRX",$J,69,1)=""
 Q
68 ;Go get data from file 68
 D A68^LR7OB68(ACD,AC,ACN)
 Q
