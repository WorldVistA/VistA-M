XUDHSET ;ISC-SF/RWF - Setup devices ;5/5/97  15:41
 ;;8.0;KERNEL;**49**;Jul 10, 1995
 Q
 ;N1 device name, N2 resource name, CNT # of slots
RES(N1,N2,CNT,LOC,SUB) ;Build a RESOURCE device entry
 N X,Y,%,XUFD,XUDA,DIC
 S:'$D(N2) N2=N1 S:'$D(CNT) CNT=1 S:'$D(LOC) LOC="Resource Device" S:'$D(SUB) SUB="P-OTHER"
 S DIC="^%ZIS(1,",DIC(0)="M",X=N1 D ^DIC I Y>0 Q "-1^Device name in use"
 S DIC="^%ZISL(3.54,",DIC(0)="M",X=N2 D ^DIC I Y>0 Q "-1^Resource name in use"
 S %=$O(^%ZIS(2,"B",SUB,0)) S:%'>0 %=$O(^%ZIS(2,"B",SUB)),%=$S(%[SUB:$O(^%ZIS(2,"B",%,0)))
 S XUDA="+1,",XUDA2="+2,"
 S XUFD(3.5,XUDA,.01)=N1,XUFD(3.5,XUDA,2)="RES",XUFD(3.5,XUDA,1)=N2,XUFD(3.5,XUDA,35)=CNT,XUFD(3.5,XUDA,.02)=LOC
 S:%>0 XUFD(3.5,XUDA,3)=%
 D UPDATE^DIE("","XUFD","XUDA")
 S %=$O(^TMP("DIERR",$J,0)) I % Q "-1^"_^(%,"TEXT",1)
 Q XUDA(1)_"^"_$P(^%ZIS(1,XUDA(1),0),"^")
