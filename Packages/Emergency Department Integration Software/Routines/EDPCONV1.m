EDPCONV1 ;SLC/MKB - Convert local ED configuration ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
CONFIG(OLD) ; -- Save local OLD(NODE) configuration into ^EDPB(231.9)
 N EDPSITE,TZDIFF,EDPAREA,X,X2,X3,X5,Y,NODE
 S EDPSITE=$G(OLD("SITE")),X=$G(OLD("TZ")),TZDIFF=0 ;$$TZONE(X)
 S EDPAREA=+$O(^EDPB(231.9,"C",EDPSITE,0)) Q:EDPAREA<1
 S X2=$G(OLD(2)),X3=$G(OLD(3)),X5=$G(OLD(5))
 ; update entry
 S:$L(TZDIFF) $P(^EDPB(231.9,EDPAREA,0),U,3)=TZDIFF
 S NODE=$G(^EDPB(231.9,EDPAREA,1))
 S X=$P(X5,U,1) S:$L(X) $P(NODE,U,1)=X ;Dx Reqd
 S X=$P(X5,U,4) S:$L(X) $P(NODE,U,3)=X ;Disp Reqd
 S X=$P(X5,U,5) S:$L(X) $P(NODE,U,4)=X ;Delay Reqd
 S X=$P(X5,U,6) S:$L(X) $P(NODE,U,5)=X ;Delay Minutes
 S X=$P(X2,U,4) I $L(X) D
 . S Y=(+$P(X,":")*60)+$P(X,":",2)     ;HH:MM -> minutes since Midnight
 . S $P(NODE,U,6)=Y                    ;First Shift Start
 S X=$P(X2,U,5) I X D
 . S Y=X*60                            ;hours -> minutes
 . S $P(NODE,U,7)=Y                    ;Shift Duration
 S ^EDPB(231.9,EDPAREA,1)=NODE
C1 ; Color Spec
 N CSPEC,N,I,BACK,FONT
 S CSPEC(1,0)="<colors id=""stsAcuity"" type=""val"" >",N=1
 S I="STS" F  S I=$O(OLD(I)) Q:I'?1"STS"1.N  D
 . S NODE=$G(OLD(I)),FONT=$P(NODE,U,2),BACK=$P(NODE,U,3)
 . S X="<map att=""@status"" clr=""",Y=$$STS^EDPCONV(+$P(I,"STS",2))
 . I '$L(FONT)!'$L(BACK) S X=X_"0"" val="""_Y_""" />"
 . E  S X=X_"1,"_$$CLR(BACK)_","_$$CLR(FONT)_""" val="""_Y_""" />"
 . S N=N+1,CSPEC(N,0)=X
 S I="ACU" F  S I=$O(OLD(I)) Q:I'?1"ACU"1.N  D
 . S NODE=$G(OLD(I)),FONT=$$CLR($P(NODE,U,3)),BACK=$$CLR($P(NODE,U,4))
 . S X="<map att=""@acuity"" clr=""",Y=$$ACU^EDPCONV(+$P(I,"ACU",2))
 . I '$L(FONT)!'$L(BACK) S X=X_"0"" val="""_Y_""" />"
 . E  S X=X_"1,"_BACK_","_FONT_""" val="""_Y_""" />"
 . S N=N+1,CSPEC(N,0)=X
 S N=N+1,CSPEC(N,0)="</colors>"
 F I=1:1 S X=$P($T(ORDCLR+I),";",3) Q:X="ZZZZ"  S N=N+1,CSPEC(N,0)=X
 S CSPEC(0)="^^"_N_U_N_U_DT
 K ^EDPB(231.9,EDPAREA,3) M ^(3)=CSPEC
 Q
 ;
CLR(X) ; -- Return code for color X
 I X="CLRED" Q "0xff0000"
 I X="CLBLUE" Q "0x0000ff"
 I X="CLGREEN" Q "0x00ff00"
 I X="CLYELLOW" Q "0xffff00"
 I X="CLWHITE" Q "0xffffff"
 I X="CLBLACK" Q "0x000000"
 I X="CLNAVY" Q "0x000088"
 I X="CLFUCHSIA" Q "0xff00ff"
 I X="CLMONEYGREEN" Q "0xc0dcc0"
 I X="CLSKYBLUE" Q "0xa6caf0"
 I X="CLCREAM" Q "0xfffbf0"
 I X="CLMAROON" Q "0x880000"
 I X="CLTEAL" Q "0x008888"
 I X="CLOLIVE" Q "0x888800"
 Q ""
 ;
ORDCLR ; -- default color scheme for order urgencies
 ;;<colors id="labUrg" nm="Urgency - Lab" type="val" >
 ;;<map att="@labUrg" clr="1,0x000000,0x00ff00" val="0" />
 ;;<map att="@labUrg" clr="1,0x000000,0xffff00" val="1" />
 ;;<map att="@labUrg" clr="1,0x000000,0xff0000" val="2" />
 ;;</colors>
 ;;<colors id="radUrg" nm="Urgency - Radiology" type="val" >
 ;;<map att="@radUrg" clr="1,0x000000,0x00ff00" val="0" />
 ;;<map att="@radUrg" clr="1,0x000000,0xffff00" val="1" />
 ;;<map att="@radUrg" clr="1,0x000000,0xff0000" val="2" />
 ;;</colors>
 ;;ZZZZ
 Q
