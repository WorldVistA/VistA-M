HLCSAS1 ;ISCSF/RWF - Read data ;02/05/2004  08:06
 ;;1.6;HEALTH LEVEL SEVEN;**43,57,91,109**;Oct 13, 1995
 Q
DATA(ROOT,STAT) ;get Data
 N I,M,HLROOT
 D DCODE(HCSDAT),TRACE^HLCSAS("DECODE "_HCSDAT)
 ;Check if data type is OK
 ;I ...
 S HLROOT=$$SAVE("I")
 F I=1:1 S M=$$DREAD() Q:HCSER!M  S (@ROOT@(I),@HLROOT@(I,0))=HCSDAT
 S @HLROOT@(0)="^^"_(I-1)_"^"_(I-1)_"^"_$$DT^XLFDT
 ;If we got it all
 D SEND^HLCSAS($S(HCSER:"500 Data error",1:"220 OK"))
 D LLCNT^HLCSTCP(HLDP,1)
 Q
 ;
SAVE(HLTP) ;save to file 772, HLTP: I=input, O=output
 N HLJ,HLMID,HLTIEN,HLDT,HLX,HLY,X,Y ;HL*1.6*91
 D TCP^HLTF(.HLMID,.HLTIEN,.HLDT) Q:'HLTIEN ""
 S X="HLJ(773,"""_HLTIEN_","")"
 ;3=transmission type, 4=priority, 7=Logical Link, 20=status, 100=processed
 S @X@(3)=HLTP,@X@(4)="I",@X@(7)=HLDP,@X@(20)=3,@X@(100)=$$NOW^XLFDT
 D FILE^HLDIE("K","HLJ","","SAVE","HLCSAS1") ;HL*1.6*109
 S (HLX,X)=+^HLMA(HLTIEN,0),(HLY,Y)=$NA(^HL(772,X,"IN")) ;HL*1.6*91
 D SNMSP(+HLX,$S($G(HLP("NAMESPACE"))]"":HLP("NAMESPACE"),1:"MPI")) ;HL*1.6*91
 Q HLY ;HL*1.6*91
 ;
SNMSP(IEN772,NMSP) ; Store NMSP in IEN772 (Created by HL*1.6*91)
 N HLJ,X,Y
 QUIT:'$D(^HL(772,+$G(IEN772),0))!($G(NMSP)']"")  ;->
 S X="HLJ(772,"""_+IEN772_","")"
 S @X@(16)=NMSP
 D FILE^HLDIE("","HLJ","","SNMSP","HLCSAS1") ; HL*1.6*109
 QUIT
 ;
SDATA(ROOT,TYPE) ;Send data from a source
 N I,X,Y,Z,L,D,HLROOT
 S ROOT=$NA(@ROOT),X=ROOT,Y=$E(ROOT,1,$L(ROOT)-1),HCSER=0
 D SEND^HLCSAS("DATA PARAM="_TYPE)
 S X=ROOT,HLROOT=$$SAVE("O")
 F I=1:1 S X=$Q(@X) Q:$E(X,1,$L(Y))'=Y  S Z=@X,@HLROOT@(I,0)=Z D DSEND(Z)
 S @HLROOT@(0)="^^"_(I-1)_"^"_(I-1)_"^"_$$DT^XLFDT
 D DSEND($C(27,27,27)) ;Tell other end we'r done
 D LLCNT^HLCSTCP(HLDP,4)
 Q
DCODE(D) ;Decode a DATA string
 S D=$$UP^XLFSTR(D),D=$P(D,"PARAM=",2,99)
 F I=1:1 S STAT("P"_I)=$P(D,",",I) Q:$P(D,",",I+1)=""
 Q
DREAD() ;Data read
 N L,D,R S (D,HCSDAT)="",HCSER=0
 S L=$$LREAD(3) Q:HCSER 1
 I L'?3N S HCSER="1 Out of sync: "_L Q 1
 I L>0 S HCSDAT=$$LREAD(L)
 Q HCSDAT=$C(27,27,27)
DSEND(D) ;Data send
 N L
 S L=$L(D),L=$E(1000+L,2,4)
 W L,D,! ;Flush buffer
 Q
LREAD(N) ;Read N char
 N D,C,P S D="",C=N,HCSER=0
 F  D  Q:'C!HCSER
 . R P#C:HLDREAD E  S HCSER=1 Q
 . S D=D_P,C=N-$L(D)
 . Q
 Q D
