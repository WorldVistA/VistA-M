ICDIDX ;DLS/DEK - MUMPS Cross Reference Routine ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    IXALL^DIK           ICR  10013
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; "D" on Description
SD(ICD) ; Set ROOT("D",<word>,<file ien>,<dt>,<des ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N WRDS,I,WD,CDT,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)  S EXC=$$EXC(DA(1),RT) Q:+EXC'>0
 S CDT=$G(@(RT_+($G(DA(1)))_",68,"_+($G(DA))_",0)")),CDT=$P(CDT,"^",1) Q:CDT'?7N  D PAR^ICDTOKN($G(X),.WRDS,0) S I=0
 F  S I=$O(WRDS(I)) Q:+I'>0  S WD=$G(WRDS(I)) S:$L(WD) @(RT_"""D"","""_WD_""","_+DA(1)_","_CDT_","_+DA_")")=""
 S IE1=DA(1),IE2=DA,IE3=0 F  S IE3=$O(@(RT_+IE1_",68,"_+IE2_",2,"_IE3_")")) Q:+IE3'>0  D
 . S KEY=$$TM($G(@(RT_+IE1_",68,"_+IE2_",2,"_+IE3_",0)"))) Q:'$L(KEY)
 . S @(RT_"""D"","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")=""
 Q
KD(ICD) ; Kill ROOT("D",<word>,<file ien>,<dt>,<des ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N WRDS,I,WD,CDT,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S CDT=$G(@(RT_+($G(DA(1)))_",68,"_+($G(DA))_",0)")),CDT=$P(CDT,"^",1) Q:CDT'?7N  D PAR^ICDTOKN($G(X),.WRDS,0) S I=0
 F  S I=$O(WRDS(I)) Q:+I'>0  S WD=$G(WRDS(I)) K:$L(WD) @(RT_"""D"","""_WD_""","_+DA(1)_","_CDT_","_+DA_")")
 S IE1=DA(1),IE2=DA,IE3=0 F  S IE3=$O(@(RT_+IE1_",68,"_+IE2_",2,"_IE3_")")) Q:+IE3'>0  D
 . S KEY=$$TM($G(@(RT_+IE1_",68,"_+IE2_",2,"_+IE3_",0)"))) Q:'$L(KEY)
 . K @(RT_"""D"","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")
 Q
 ; "AD" on Description
SAD(ICD) ; Set ROOT("AD",<cs>,<word>,<file ien>,<dt>,<des ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N KEY,WRDS,I,WD,CDT,SYS,EXC,RT
 S RT=$$RT(+($G(ICD))) Q:'$L(RT)  S EXC=$$EXC(DA(1),RT) Q:+EXC'>0
 S CDT=$G(@(RT_+($G(DA(1)))_",68,"_+($G(DA))_",0)")),CDT=$P(CDT,"^",1) Q:CDT'?7N
 S SYS=+($P($G(@(RT_+DA(1)_",1)")),"^",1)) Q:+SYS'>0  D PAR^ICDTOKN($G(X),.WRDS,0) S I=0
 F  S I=$O(WRDS(I)) Q:+I'>0  D
 . S WD=$G(WRDS(I)) S:$L(WD) @(RT_"""AD"","_+SYS_","""_WD_""","_+DA(1)_","_CDT_","_+DA_")")=""
 S IE1=DA(1),IE2=DA,IE3=0
 F  S IE3=$O(@(RT_+IE1_",68,"_+IE2_",2,"_IE3_")")) Q:+IE3'>0  D
 . S KEY=$$TM($G(@(RT_+IE1_",68,"_+IE2_",2,"_+IE3_",0)"))) Q:'$L(KEY)
 . S @(RT_"""AD"","_+SYS_","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")=""
 . S @(RT_"""D"","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")=""
 Q
KAD(ICD) ; Kill ROOT("AD",<cs>,<word>,<file ien>,<dt>,<des ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N KEY,WRDS,I,WD,CDT,SYS,EXC,RT,IE1,IE2,IE3 S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S CDT=$G(@(RT_+($G(DA(1)))_",68,"_+($G(DA))_",0)")),CDT=$P(CDT,"^",1) Q:CDT'?7N
 S SYS=+($P($G(@(RT_+DA(1)_",1)")),"^",1)) Q:+SYS'>0  D PAR^ICDTOKN($G(X),.WRDS,0) S I=0
 F  S I=$O(WRDS(I)) Q:+I'>0  S WD=$G(WRDS(I)) K:$L(WD) @(RT_"""AD"","_+SYS_","""_WD_""","_+DA(1)_","_CDT_","_+DA_")")
 S IE1=DA(1),IE2=DA,IE3=0
 F  S IE3=$O(@(RT_+IE1_",68,"_+IE2_",2,"_IE3_")")) Q:+IE3'>0  D
 . S KEY=$$TM($G(@(RT_+IE1_",68,"_+IE2_",2,"_+IE3_",0)"))) Q:'$L(KEY)
 . K @(RT_"""AD"","_+SYS_","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")
 . K @(RT_"""D"","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")
 Q
 ; "AD" on Coding System
SAD2(ICD) ; Set ROOT("AD",<cs>,<word>,<file ien>,<dt>,<des ien>)
 Q:'$L($G(X))  Q:+($G(DA))'>0  N WRDS,I,WD,TXT,KEY,CDT,SYS,IE1,IE2,IE3,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)  S EXC=$$EXC(DA,RT) Q:+EXC'>0
 S SYS=+($G(X)) Q:+SYS'>0  S IE1=+($G(DA)),IE2=0 F  S IE2=$O(@(RT_+IE1_",68,"_IE2_")")) Q:+IE2'>0  D
 . N I S CDT=$P($G(@(RT_+IE1_",68,"_IE2_",0)")),"^",1) Q:CDT'?7N
 . S TXT=$G(@(RT_+IE1_",68,"_IE2_",1)")) I $L(TXT) D
 . . D PAR^ICDTOKN(TXT,.WRDS,0) S I=0 F  S I=$O(WRDS(I)) Q:+I'>0  S WD=$G(WRDS(I)) D
 . . . S:$L(WD) @(RT_"""AD"","_+SYS_","""_WD_""","_+IE1_","_CDT_","_+IE2_")")=""
 . S IE3=0 F  S IE3=$O(@(RT_+IE1_",68,"_+IE2_",2,"_IE3_")")) Q:+IE3'>0  D
 . . S KEY=$$TM($G(@(RT_+IE1_",68,"_+IE2_",2,"_+IE3_",0)"))) Q:'$L(KEY)
 . . S @(RT_"""AD"","_+SYS_","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")=""
 . . S @(RT_"""D"","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")=""
 Q
KAD2(ICD) ; Kill ROOT("AD",<cs>,<word>,<file ien>,<dt>,<des ien>)
 Q:'$L($G(X))  Q:+($G(DA))'>0  N WRDS,I,WD,TXT,CDT,SYS,IE1,IE2,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S SYS=+($G(X)) Q:+SYS'>0  S IE1=+($G(DA)),IE2=0 F  S IE2=$O(@(RT_+IE1_",68,"_IE2_")")) Q:+IE2'>0  D
 . N I S CDT=$P($G(@(RT_+IE1_",68,"_IE2_",0)")),"^",1) Q:CDT'?7N
 . S TXT=$G(@(RT_+IE1_",68,"_IE2_",1)")) I $L(TXT) D
 . . D PAR^ICDTOKN(TXT,.WRDS,0) S I=0 F  S I=$O(WRDS(I)) Q:+I'>0  S WD=$G(WRDS(I)) D
 . . . K:$L(WD) @(RT_"""AD"","_+SYS_","""_WD_""","_+IE1_","_CDT_","_+IE2_")")
 . S IE3=0 F  S IE3=$O(@(RT_+IE1_",68,"_+IE2_",2,"_IE3_")")) Q:+IE3'>0  D
 . . S KEY=$$TM($G(@(RT_+IE1_",68,"_+IE2_",2,"_+IE3_",0)"))) Q:'$L(KEY)
 . . K @(RT_"""AD"","_+SYS_","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")
 . . K @(RT_"""D"","""_KEY_""","_+IE1_","_CDT_","_+IE2_","_+IE3_")")
 Q
 ; "AD" on Keywords
SAD3(ICD) ; Set ROOT("AD",<cs>,<word>,<file ien>,<dt>,<des ien>,<wd ien>)
 N KEY S KEY=$$UP^XLFSTR($$TM($G(X))) Q:'$L(KEY)  Q:+($G(DA(2)))'>0  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0
 N CDT,SYS,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)  S EXC=$$EXC(DA(2),RT) Q:+EXC'>0
 S CDT=$G(@(RT_+($G(DA(2)))_",68,"_+($G(DA(1)))_",0)")),CDT=$P(CDT,"^",1) Q:CDT'?7N
 S SYS=+($P($G(@(RT_+DA(2)_",1)")),"^",1)) Q:+SYS'>0
 S @(RT_"""AD"","_+SYS_","""_KEY_""","_+DA(2)_","_CDT_","_+DA(1)_","_+DA_")")=""
 S @(RT_"""D"","""_KEY_""","_+DA(2)_","_CDT_","_+DA(1)_","_+DA_")")=""
 Q
KAD3(ICD) ; Kill ROOT("AD",<cs>,<word>,<file ien>,<dt>,<des ien>,<wd ien>)
 N KEY S KEY=$$UP^XLFSTR($$TM($G(X))) Q:'$L(KEY)  Q:+($G(DA(2)))'>0  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0
 N CDT,SYS,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)  S EXC=$$EXC(DA(2),RT) Q:+EXC'>0
 S CDT=$G(@(RT_+($G(DA(2)))_",68,"_+($G(DA(1)))_",0)")),CDT=$P(CDT,"^",1) Q:CDT'?7N
 S SYS=+($P($G(@(RT_+DA(2)_",1)")),"^",1)) Q:+SYS'>0
 K @(RT_"""AD"","_+SYS_","""_KEY_""","_+DA(2)_","_CDT_","_+DA(1)_","_+DA_")")
 K @(RT_"""D"","""_KEY_""","_+DA(2)_","_CDT_","_+DA(1)_","_+DA_")")
 Q
 ; "AST" on short text effective date
SAST(ICD) ; Set ROOT("AST",<code>,<dt>,<file ien>,<st ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S EXC=+($$EXC(DA(1),RT)) Q:+EXC'>0  S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 S SYS=$P($G(@(RT_DA(1)_",1)")),"^",1) S @(RT_"""AST"","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")=""
 Q
KAST(ICD) ; Kill ROOT("AST",<code>,<dt>,<file ien>,<st ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 S SYS=$P($G(@(RT_DA(1)_",1)")),"^",1) K @(RT_"""AST"","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")
 Q
 ; "ASTS" on short text effective date
SASTS1(ICD) ; Set ROOT("ASTS",<cs>,<code>,<dt>,<file ien>,<st ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S EXC=+($$EXC(DA(1),RT)) Q:+EXC'>0  S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 S SYS=$P($G(@(RT_DA(1)_",1)")),"^",1) Q:+SYS'>0
 S @(RT_"""ASTS"","_+SYS_","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")=""
 Q
KASTS1(ICD) ; Kill ROOT("ASTS",<cs>,<code>,<dt>,<file ien>,<st ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 S SYS=$P($G(@(RT_DA(1)_",1)")),"^",1) Q:+SYS'>0
 K @(RT_"""ASTS"","_+SYS_","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")
 Q
 ; "ASTS" on short text
SASTS2(ICD) ; Set ROOT("ASTS",<cs>,<code>,<dt>,<file ien>,<st ien>)
 Q:'$L($G(X))  Q:+($G(DA))'>0  N WRDS,I,WD,TXT,COD,CDT,SYS,IE1,IE2,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S EXC=$$EXC(DA,RT) Q:+EXC'>0  S SYS=+($G(X)) Q:+SYS'>0  S COD=$P($G(@(RT_+($G(DA))_",0)")),"^",1) Q:'$L(COD)
 S IE1=+($G(DA)),IE2=0 F  S IE2=$O(@(RT_+IE1_",67,"_IE2_")")) Q:+IE2'>0  D
 . N I S CDT=$P($G(@(RT_+IE1_",67,"_IE2_",0)")),"^",1) Q:CDT'?7N
 . S @(RT_"""ASTS"","_+SYS_","""_(COD_" ")_""","_CDT_","_IE1_","_IE2_")")=""
 Q
KASTS2(ICD) ; Set ROOT("ASTS",<cs>,<code>,<dt>,<file ien>,<dx ien>)
 Q:'$L($G(X))  Q:+($G(DA))'>0  N WRDS,I,WD,TXT,COD,CDT,SYS,IE1,IE2,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S SYS=+($G(X)) Q:+SYS'>0  S COD=$P($G(@(RT_+($G(DA))_",0)")),"^",1) Q:'$L(COD)
 S IE1=+($G(DA)),IE2=0 F  S IE2=$O(@(RT_+IE1_",67,"_IE2_")")) Q:+IE2'>0  D
 . N I S CDT=$P($G(@(RT_+IE1_",67,"_IE2_",0)")),"^",1) Q:CDT'?7N
 . K @(RT_"""ASTS"","_+SYS_","""_(COD_" ")_""","_CDT_","_IE1_","_IE2_")")
 Q
 ;
SADS(ICD) ; Set ROOT("ADS",<code>,<dt>,<file ien>,<dx ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S EXC=+($$EXC(DA(1),RT)) Q:+EXC'>0  S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 S @(RT_"""ADS"","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")=""
 Q
KADS(ICD) ; Kill ROOT("ADS",<code>,<dt>,<file ien>,<dx ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 K @(RT_"""ADS"","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")
 Q
SADSS1(ICD) ; Set ROOT("ADSS",SYS,<code>,<dt>,<file ien>,<dx ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S EXC=+($$EXC(DA(1),RT)) Q:+EXC'>0  S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 S SYS=$P($G(@(RT_DA(1)_",1)")),"^",1) Q:+SYS'>0
 S @(RT_"""ADSS"","_+SYS_","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")=""
 Q
KADSS1(ICD) ; Kill ROOT("ADSS",SYS,<code>,<dt>,<file ien>,<dx ien>)
 Q:'$L($G(X))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  N EXC,COD,SYS,RT,CDT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S CDT=+($G(X)) Q:CDT'?7N  S COD=$P($G(@(RT_DA(1)_",0)")),"^",1) Q:'$L(COD)
 S SYS=$P($G(@(RT_DA(1)_",1)")),"^",1) Q:+SYS'>0
 K @(RT_"""ADSS"","_+SYS_","""_(COD_" ")_""","_CDT_","_DA(1)_","_DA_")")
 Q
SADSS2(ICD) ; Set ROOT("ADSS",SYS,<code>,<dt>,<file ien>,<dx ien>)
 Q:'$L($G(X))  Q:+($G(DA))'>0  N WRDS,I,WD,TXT,COD,CDT,SYS,IE1,IE2,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S EXC=$$EXC(DA,RT) Q:+EXC'>0  S SYS=+($G(X)) Q:+SYS'>0  S COD=$P($G(@(RT_+($G(DA))_",0)")),"^",1) Q:'$L(COD)
 S IE1=+($G(DA)),IE2=0 F  S IE2=$O(@(RT_+IE1_",68,"_IE2_")")) Q:+IE2'>0  D
 . N I S CDT=$P($G(@(RT_+IE1_",68,"_IE2_",0)")),"^",1) Q:CDT'?7N
 . S @(RT_"""ADSS"","_+SYS_","""_(COD_" ")_""","_CDT_","_IE1_","_IE2_")")=""
 Q
KADSS2(ICD) ; Set ROOT("ADSS",SYS,<code>,<dt>,<file ien>,<dx ien>)
 Q:'$L($G(X))  Q:+($G(DA))'>0  N WRDS,I,WD,TXT,COD,CDT,SYS,IE1,IE2,EXC,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S SYS=+($G(X)) Q:+SYS'>0  S COD=$P($G(@(RT_+($G(DA))_",0)")),"^",1) Q:'$L(COD)
 S IE1=+($G(DA)),IE2=0 F  S IE2=$O(@(RT_+IE1_",68,"_IE2_")")) Q:+IE2'>0  D
 . N I S CDT=$P($G(@(RT_+IE1_",68,"_IE2_",0)")),"^",1) Q:CDT'?7N
 . K @(RT_"""ADSS"","_+SYS_","""_(COD_" ")_""","_CDT_","_IE1_","_IE2_")")
 Q
SAEXC(ICD) ; Set ROOT("AEXC",<code>,<ien>)
 Q:+($G(DA))'>0  N COD,EXC,RT  S RT=$$RT(+($G(ICD))) Q:'$L(RT)  S COD=$P($G(@(RT_+DA_",0)")),"^",1) Q:'$L(COD)
 S EXC=$$EXC(DA,RT) S:+EXC'>0 @(RT_"""AEXC"","""_(COD_" ")_""","_DA_")")=""
 Q
KAEXC(ICD) ; Kill ROOT("AEXC",<code>,<ien>)
 Q:+($G(DA))'>0  N COD,EXC,RT  S RT=$$RT(+($G(ICD))) Q:'$L(RT)  S COD=$P($G(@(RT_+DA_",0)")),"^",1) Q:'$L(COD)
 K @(RT_"""AEXC"","""_(COD_" ")_""","_DA_")")
 Q
 ;
 ; Miscellaneous
EXC(X,Y) ;   Exclude from lookup
 N COD,EFF,LDS,IEN,RT S IEN=+($G(X)),RT=$G(Y) Q:+IEN'>0 0  Q:'$L(RT) 0  S COD=$P($G(@(RT_+IEN_",0)")),"^",1)
 S EFF=$O(@(RT_+IEN_",66,0)")),LDS=$O(@(RT_+IEN_",68,0)")) Q:$L(COD)&(+EFF>0)&(+LDS>0) 1
 Q 0
RM(ICD) ;   Remove Main
 N IX,RT S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S IX=" " F  S IX=$O(@(RT_""""_IX_""")")) Q:'$L(IX)  D
 . K @(RT_""""_IX_""")")
 Q
RE(ICD) ;   Re-Index
 N ZTQUEUED,DIK,IX,RT,DA S RT=$$RT(+($G(ICD))) Q:'$L(RT)
 S DIK=RT,ZTQUEUED="" D IXALL^DIK
 Q
RT(X) ;   Root from File #
 Q $S(+($G(X))=80:$$ROOT^ICDEX(80),+($G(X))=80.1:$$ROOT^ICDEX(80.1),1:"")
TM(X,Y) ;   Trim Y
 S X=$G(X),Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
