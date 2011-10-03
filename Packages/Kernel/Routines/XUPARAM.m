XUPARAM ;SF/RWF - Lookup parameter substitute, KSP values ;03/26/2003  11:56
 ;;8.0;KERNEL;**65,115,224**;Jul 10, 1995
 Q
GET(%X,STYLE) ;Get substitute value
 ;Style, N will return call name as default
 ;       V will return null as default
 ;otherwize will return zero as default
 N %1,%2,%Y S STYLE=$G(STYLE),%Y=$S(STYLE="N":%X,STYLE="V":"",1:0)
 S %1=$$LKUP(%X) I %1'>0 Q %Y
 S %2=$G(^XTV(8989.2,%1,0))
 I $P(%2,"^",4)]"" Q $P(%2,"^",4)
 I $P(%2,"^",3)]"" Q $P(%2,"^",3)
 Q %Y
SET(%X,VALUE,DEF) ;Set parameter value, default
 N %1
 S %1=$$LKUP(%X,"A") Q:%1'>0
 Q:'$D(VALUE)
 S $P(^XTV(8989.2,%1,0),"^",4)=VALUE S:$G(DEF)]"" $P(^XTV(8989.2,%1,0),"^",3)=DEF
 Q
LKUP(X,ACTION) ;
 N E
 S E=$O(^XTV(8989.2,"B",X,0)) I E>0 Q E
 I $G(ACTION)'["A" Q -1
 N DA,DIC,DLAYGO,Y
 S DIC="^XTV(8989.2,",DIC(0)="ML",DLAYGO=8989.2 D FILE^DICN
 Q +Y
 ;
BAT() Q $P($G(^XTV(8989.3,1,"XWB"),180),U) ;Broker Activity timeout
 ;
KSP(NAME) ;To return data from KSP file.
 N NM S NM=$P($G(NAME)," ")
 Q:'$L(NM) "" ;No parameter value
 Q:$T(@NM)="" ""  G @NM
SPOOL Q $P($G(^XTV(8989.3,1,"SPL")),"^",$S(NAME["LINE":1,NAME["DOC":2,NAME["LIFE":3,1:1))
WHERE Q $P($G(^DIC(4.2,(+^XTV(8989.3,1,0)),0)),"^")
INST Q $P($G(^XTV(8989.3,1,"XUS")),U,17)
LIFETIME Q $P($G(^XTV(8989.3,1,"XUS")),U,15) ;Verify code lifetime
