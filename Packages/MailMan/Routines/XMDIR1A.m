XMDIR1A ;(WASH ISC)/CAP-Load VACO Directories (WANG) ;04/17/2002  08:47
 ;;8.0;MailMan;;Jun 28, 2002
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="EOF^XMDIR1A",@^%ZOSF("TRAP"),XMB0=^%ZOSF("UPPERCASE")
 G P:'$D(ZTQUEUED)
 ;Batch processing begins here
R1 U IO R Y:DTIME I '$D(ZTQUEUED) U IO(0)
 S XMA=XMA+1 I '$D(ZTQUEUED),XMA#10=0 W "."
P S X=Y X XMB0 F %=0:0 Q:$E(Y)'?1P  S Y=$E(Y,2,99)
 F %=$L(Y):-1:0 Q:$E(Y,%)?1A  S Y=$E(Y,1,%-1)
 K X S X=$P(Y,"*")
 G R1:X[" ",R1:X["@",R1:X["::",R1:X[".."
 S XMY=Y
 ;
1 ;Name
 S X("LN")=$P(X,".",$L(X,".")),X=$P(X,".",1,$L(X,".")-1)
 G R1:'$L(X("LN")),R1:X("LN")?1.N,R1:X("LN")?.E3N.E,R1:X("LN")["/"
 G R1:X("LN")?.E1C.E
 S X("FN")=$P(X,"."),X=$P(X,".",2,9),X("RN")=X
 ;
 ;Mail code
 S X=$P(Y,"*",2),X("MC")=$P(X," "),X("EMC")=X G R1:X("MC")?.E1C.E
 ;
 ;Location
 S X("L")=$P(Y,"*",3)
 ;
 ;Network address
 S Y=$P(XMY,"*") G R1:'$L(Y),R1:Y?.E1C.E S X("NET")=Y_"@VACOWMAIL.VA.GOV"
 I $D(^XMD(4.2997,"B",X("LN"))) S %="" F  S %=$O(^XMD(4.2997,"B",X("LN"),%)) Q:%=""  I $D(^XMD(4.2997,%,0)) S %6=^XMD(4.2997,%,0) I X("NET")=$P(%6,U,7) S XME="Already on file - not filed " D ER^XMDIR1 G R1
 ;
 D FILE(.X)
 G R1
FILE(X) ;HARD CODE
 ;
 ;X("EMC")=Extended Mail Code
 ;X("FN")=First name
 ;X("L")=Location
 ;X("LN")=Last name
 ;X("MC")=Mail Code
 ;X("NET")=full NETwork address
 ;X("PHONE")=Phone number
 ;X("PHONE/E")=Telephone Extension
 ;X("RN")=Restofname
 ;
 ;Get new entry number
 N %,N,Y L +^XMD(4.2997,0)
 S Y=^XMD(4.2997,0) F N=$P(Y,U,4)+1:1 Q:'$D(^(N))
 L +^XMD(4.2997,N) S $P(Y,U,4)=N,^XMD(4.2997,0)=Y
 ;File entry
 S ^XMD(4.2997,N,0)=X("LN")_U_X("FN")_U_X("RN")_U_X("MC")_U_X("EMC")_U_X("L")_U_X("NET")_U_+$H_U_XMDIR1,^("AUTO")=XMDIR1A("CODE")
 I $D(X("PHONE"))!$D(X("PHONE/X")) S %=$G(X("PHONE")) S:$L($G(X("PHONE/X"))) %=%_U_X("PHONE/X") S ^XMD(4.2997,N,1)=%
 ;Create cross references for one entry
 S DIK="^XMD(4.2997,",DA=N D IX^DIK L -^XMD(4.2997,0),-^XMD(4.2997,N)
 Q
EOF D ^%ZISC,END("WANG",90) Q
END(X,Y) ;END PROCESSING
 ;X=NAME OF FILE (WANG or NOAVA)
 ;Y=Subscript of text array
 N A S A=X,XMDIR1($E(X))=XMA
 S ^TMP("XMDIR1",$J,.01)="Normal error reported here",^(.02)="("_$ZE_")",^(.03)="should be end of File."
 S ^TMP("XMDIR1",$J,.04)="Done processing "_A_" file on "_$$HTE^XLFDT($H,5)
 S ^TMP("XMDIR1",$J,.05)=""
 Q
