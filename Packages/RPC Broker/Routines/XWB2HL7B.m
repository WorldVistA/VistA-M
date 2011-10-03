XWB2HL7B ;ISF/AC  - Remote RPCs via HL7. ;03/27/2003  17:46
 ;;1.1;RPC BROKER;**12,22,39**;Mar 28, 1997
RPCRECV ;Called from the XWB RPC CLIENT protocol
 ;Called on the remote system
 N I,I1,J,XWB2EMAP,XWB2IPRM,XWB2LPRM,XWB2MAP2,XWB2PEND,XWB2QTAG,XWB2RNAM,XWB2RFLD,CMPNTREM,XWB2RPCP,XWB2SPN,XWB2RSLT,XWB2Y,Y
 F I=1:1 X HLNEXT Q:HLQUIT'>0  S XWB2Y(I)=HLNODE,J=0 F  S J=$O(HLNODE(J)) Q:'J  S XWB2Y(I,J)=HLNODE(J)
 ;Define Encoding characters to map by order
 S Y=""
 F I=3,0,1,2,4 S Y=Y_$S(I:$E(HL("ECH"),I),1:HL("FS"))
 S XWB2EMAP=Y,XWB2MAP2="EFSRT"
 D PARSSPR G GENACK:$G(HLERR)]""
 ;Merge into the parameter list the last of the remainder
 ;nodes that have not been processed.
 S I1=$O(XWB2RPCP("R",0)) I I1 D
 .M XWB2RPCP(I1)=XWB2RPCP("R",I1)
 .K XWB2RPCP("R")
 D COMPRES(.XWB2RPCP)
 ;Call to build and do rpc
 D REMOTE^XWB2HL7(.XWB2RNAM,XWB2QTAG,XWB2SPN,.XWB2RPCP)
GENACK ;Generate ack/nak
 K ^TMP("HLA",$J)
 S ^TMP("HLA",$J,1)="MSA"_HL("FS")_$S($G(HLERR)]"":"AE",1:"AA")_HL("FS")_HL("MID")_$S($G(HLERR)]"":HL("FS")_HLERR,1:"")
 S ^TMP("HLA",$J,2)="QAK"_HL("FS")_XWB2QTAG_HL("FS")_$S($G(HLERR)]"":"AE",1:"OK")
 S ^TMP("HLA",$J,3)="RDF"_HL("FS")_"1"_HL("FS")_"@DSP.3"_$E(HL("ECH"))_"TX"_$E(HL("ECH"))_"300"
 D:$G(HLERR)']"" BLDRDT
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.XWB2RSLT)
RECVXIT ;Cleanup of receiver processing sub-routine
 K ^TMP("HLA",$J)
 Q
 ;
PARSSPR ;Parse SPR segment for paramaeters.
 N %,%1
 S I=2
 ;Extract handle
 S XWB2QTAG=$P(XWB2Y(I),HL("FS"),2)
 ;Extract Stored Procedure Name
 S XWB2SPN=$P(XWB2Y(I),HL("FS"),4)
 ;Extract Input Parameters
 S XWB2IPRM=$P(XWB2Y(I),HL("FS"),5)
 ;Determine whether Input Parameters fit on one line of SPR segment.
 ;XWB2LPRM=1 if parameters continue on overflow nodes.
 ;XWB2LPRM=0 if parameters fit on a single node.
 S XWB2LPRM=$S($L(XWB2Y(I),HL("FS"))=5:$S($O(XWB2Y(I,0)):1,1:0),1:0)
 ;Format of
 ;INPUT PARAMETERS:@SPR.4.2~PARAM1&PARAM2
 ;
 ;Short SPR segment
 I 'XWB2LPRM S %=$P(XWB2Y(I),HL("FS"),5) D INPUTPRM(%,0) Q
 ;Long SPR segment
 S %=$P(XWB2Y(I),HL("FS"),5,9999)
 F %1=0:0 S %1=$O(XWB2Y(I,%1)) D INPUTPRM(%,(%1>0)) Q:%1'>0!$G(XWB2PEND)  S %=XWB2Y(I,%1)
 ;
 Q
 ;
INPUTPRM(X1,L1) ;Process Input Parameters
 ;X1 contains an extract of Input Parameters
 ;L1=0 if Parameters fit on a single SPR Segment node.
 ;L1=1 if Parameters do not fit on a single SPR Segment node.
 N I,IL,Y1
 S IL=$L(X1,HL("FS"))
 S Y1=$P(X1,HL("FS"),1)
 I $G(L1),IL'>1 D REPEATLP(Y1,1) S:$G(HLERR)]"" XWB2PEND=1 Q
 D REPEATLP(Y1)
 I IL>1!($G(HLERR)]"") S XWB2PEND=1
 Q
REPEATLP(X2,L2) ;Loop through repeatable components.
 ;X2 contains an extract of Input Parameters
 ;$G(L2)>0 if component may extend onto overflow node.
 N I,RL,Y2
 S RL=$L(X2,$E(HL("ECH"),2))
 F I=1:1:RL D  Q:$G(HLERR)]""
 .S Y2=$P(X2,$E(HL("ECH"),2),I)
 .I $G(L2),I=RL D COMPONT(Y2,1) Q
 .D COMPONT(Y2)
 Q
COMPONT(X3,L3) ;Loop through the two components.
 ;X3 contains an extract of a component.
 ;$G(L3)>0 if component may extend onto next overflow node.
 N CL,I,Y3
 S CL=$L(X3,$E(HL("ECH")))
 I CL>2 S HLERR="Too many components!" Q
 I CL=2 D  Q
 .S Y3=$P(X3,$E(HL("ECH")),1)
 .;CHECK FLD REMAINDER,
 .S I=$O(XWB2RFLD("R",0)) I I D  Q:$G(HLERR)]""
 ..I ($L(XWB2RFLD("R",+I))+$L(Y3))>255 S HLERR="Field name too long!" Q
 ..S XWB2RFLD(+I)=XWB2RFLD("R",+I)_Y3
 ..K XWB2RFLD("R",+I)
 .S I=+$O(XWB2RFLD("@"),-1)+1
 .S XWB2RFLD(I)=Y3
 .;CLEAR FLD REMAINDER
 .S Y3=$P(X3,$E(HL("ECH")),2)
 .D SUBCMPNT(Y3,$G(L3))
 .;SET COMPONENT REMAINDER FLAG.
 .S CMPNTREM=$G(L3)
 I CL=1 D  Q
 .S Y3=$P(X3,$E(HL("ECH")),1)
 .I $G(CMPNTREM) D SUBCMPNT(Y3,$G(L3)) Q
 .S I=$O(XWB2RFLD("R",0)) I I D  Q
 ..I ($L(XWB2RFLD("R",+I))+$L(Y3))>255 S HLERR="Field name too long!" Q
 ..S XWB2RFLD(+I)=XWB2RFLD("R",+I)_Y3
 ..K XWB2RFLD("R",+I)
 ;
 Q
SUBCMPNT(X4,L4) ;Loop through sub-components.
 ;X4 contains an extract of the subcomponent.
 ;L4=0 if subcomponent does not extend onto next overflow node.
 ;L4=1 if subcomponent does extend onto next overflow node.
 N I,I1,I2,RMNDRLEN,SL,Y4
 S SL=$L(X4,$E(HL("ECH"),4))
 F I=1:1:SL D
 .S Y4=$P(X4,$E(HL("ECH"),4),I)
 .I $G(L4),I=SL D  Q
 ..;Long node, find last remainder
 ..S I1=$O(XWB2RPCP("R",0))
 ..I 'I1 D
 ...;No remainder, create remainder for next parameter(subcomponent).
 ...S I1=+$O(XWB2RPCP("@"),-1)+1
 ...S XWB2RPCP("R",I1)=Y4 Q
 ..E  D
 ...;Remainder exists, find last remainder overflow
 ...S I2=+$O(XWB2RPCP("R",I1,"@"),-1)+1
 ...;Length of last remainder
 ...S RMNDRLEN=$S(I2=1:$L(XWB2RPCP("R",I1)),1:$L(XWB2RPCP("R",I1,I2-1)))
 ...;If last remainder has space, squeeze more chars onto last remainder.
 ...I RMNDRLEN<255 D
 ....I I2=1 D  Q
 .....S XWB2RPCP("R",I1)=XWB2RPCP("R",I1)_$E(Y4,1,255-RMNDRLEN)
 .....S Y4=$E(Y4,1+(255-RMNDRLEN),$L(Y4))
 ....E  D
 .....S XWB2RPCP("R",I1,I2-1)=XWB2RPCP("R",I1,I2-1)_$E(Y4,1,255-RMNDRLEN)
 .....S Y4=$E(Y4,1+(255-RMNDRLEN),$L(Y4))
 ...;Save remaining chars in Y4 in current remainder node.
 ...S XWB2RPCP("R",I1,I2)=Y4
 .;Merge Remainder nodes into primary nodes.
 .;then remove Remainder nodes.
 .S I1=$O(XWB2RPCP("R",0)) I I1 D  Q
 ..S I2=+$O(XWB2RPCP("R",I1,"@"),-1)+1
 ..S RMNDRLEN=$S(I2=1:$L(XWB2RPCP("R",I1)),1:$L(XWB2RPCP("R",I1,I2-1)))
 ..I RMNDRLEN<255 D
 ...I I2=1 D  Q
 ....S XWB2RPCP("R",I1)=XWB2RPCP("R",I1)_$E(Y4,1,255-RMNDRLEN)
 ....S Y4=$E(Y4,1+(255-RMNDRLEN),$L(Y4))
 ...E  D
 ....S XWB2RPCP("R",I1,I2-1)=XWB2RPCP("R",I1,I2-1)_$E(Y4,1,255-RMNDRLEN)
 ....S Y4=$E(Y4,1+(255-RMNDRLEN),$L(Y4))
 ..S:Y4]"" XWB2RPCP("R",I1,I2)=Y4
 ..M XWB2RPCP(I1)=XWB2RPCP("R",I1)
 ..K XWB2RPCP("R")
 .S I1=+$O(XWB2RPCP("@"),-1)+1
 .S XWB2RPCP(I1)=Y4
 Q
 ;
BLDRDT ;Build RDT segments.
 N RDTNODE,NODELEN,I,NODERDT
 S RDTNODE=XWB2RNAM,NODERDT=$E(XWB2RNAM,1,$L(XWB2RNAM)-($E(XWB2RNAM,$L(XWB2RNAM))=")"))
 I '($D(@RDTNODE)#2) D  Q:RDTNODE'[NODERDT
 .S RDTNODE=$Q(@RDTNODE)
 F I=4:1 D  S RDTNODE=$Q(@RDTNODE) Q:RDTNODE'[NODERDT
 .S NODELEN=$L(@RDTNODE)
 .I NODELEN'>241 S ^TMP("HLA",$J,I)="RDT"_HL("FS")_@RDTNODE Q
 .S ^TMP("HLA",$J,I)="RDT"_HL("FS")_$E(@RDTNODE,1,241)
 .S ^TMP("HLA",$J,I,1)=$E(@RDTNODE,242,9999)
 Q
 ;
DXLATE(X,OVFL) ;TRANSLATE encoded characters back to there Formating codes.
 ;Undoes the work of XLATE^XWB2HL7A,  \F\ > ^
 N D,I,I1,L,L1,X1,X2,Y
 S D=$E(HL("ECH"),3),L=$F(X,D),OVFL=""
 I 'L Q X
 F  D  S L=$F(X,D,L) Q:'L
 . S L1=$F(XWB2MAP2,$E(X,L))
 . I L1'>1 D  Q
 . .I L1=1 S OVFL=$E(X,L-1),X=$E(X,1,$L(X)-1)
 . I L=$L(X) S OVFL=$E(X,L-1,L),X=$E(X,1,L-2) Q
 . S X2=$E(XWB2EMAP,L1-1)
 . S $E(X,L-1,L+1)=X2,L=0
 Q X ;Return the converted string
 ;
COMPRES(XWB2P) ;DXLATE AND COMPRESS ARRAY.
 N CNODE,E,I,J,L,L1,NNODE,XWB2X1,XWB2X2
 S E=$E(HL("ECH"),3)
 F I=0:0 S I=$O(XWB2P(I)) Q:I'>0  D
 .S CNODE=$NA(XWB2P(I))
 .S @CNODE=$$DXLATE(@CNODE,.XWB2X1)
 .S L=$L(@CNODE),NNODE=CNODE
 .F  S NNODE=$$NEXTNODE(NNODE) Q:NNODE']""  D
 ..I $G(XWB2X1)]"" D
 ...S L1=$L(XWB2X1)
 ...S XWB2X2=$E(@NNODE,1,3-L1)
 ...S Y=$$DXLATE(XWB2X1_XWB2X2)
 ...I $L(Y)=1 D
 ....S @CNODE=@CNODE_Y
 ....S @NNODE=$E(@NNODE,3-L1+1,$L(@NNODE))
 ...E  S @CNODE=@CNODE_XWB2X1
 ..S CNODE=NNODE
 ..K XWB2X1 S @CNODE=$$DXLATE(@CNODE,.XWB2X1)
 .I $G(XWB2X1)]"" S @CNODE=@CNODE_XWB2X1
 ;Compress nodes
 F I=0:0 S I=$O(XWB2P(I)) Q:I'>0  D
 .S CNODE=$NA(XWB2P(I))
 .S L=$L(@CNODE)
 .S NNODE=CNODE
 .F  Q:NNODE']""  S NNODE=$$NEXTNODE(NNODE) Q:NNODE']""  D
 ..I L'<255 S CNODE=NNODE,L=$L(@CNODE) Q
 ..F  S NNODE=$$NEXTNODE(NNODE) Q:NNODE']""  D  I L=255 S NNODE=CNODE Q
 ...S L1=$L(@NNODE)
 ...I 'L1 Q
 ...S $E(@CNODE,L+1,255)=$E(@NNODE,1,255-L)
 ...S @NNODE=$E(@NNODE,255-L+1,255)
 ...S L=$L(@CNODE)
 .;Clean up excess nodes
 .S NNODE=CNODE
 .F  S NNODE=$$NEXTNODE(NNODE) Q:NNODE']""  D
 ..I '$L(@NNODE) K @NNODE
 Q
 ;
NEXTNODE(%) ;Get next node from $NA reference.
 N QL,QS,X1,Y
 S QL=$QL($NA(@%))
 I QL=1 S X1=$O(@%@(0)),Y=$S(X1:$NA(@%@(X1)),1:"") Q Y
 I QL=2 D  Q Y
 .S X1=$O(@%),Y=$S(X1:$NA(@$NA(@%,1)@(X1)),1:"") Q
 Q "" ;Error, should not have more than two nodes.
