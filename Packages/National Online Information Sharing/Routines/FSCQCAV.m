FSCQCAV ;SLC/STAFF-NOIS Query Criteria Ask Value ;8/25/94  17:14
 ;;1.1;NOIS;;Sep 06, 1998
 ;
VALUE(COND,TYPE) ; from FSCLMPME, FSCQB
 N DIC,DIR,VALUE1,VALUE2
 S VALUE=""
 I $P(COND,U,3)="exists" Q
 I $P(COND,U,3)="not exists" Q
 S DIR("?")="^D HELP^FSCQD"
 ;
 ; free-text values
 I TYPE["F"!(TYPE["W") D  Q
 .S DIR(0)="FAO^1:30",DIR("A")="Text: "
 .S DIR("?",1)="Enter the text to be used in the search."
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR
 .S VALUE=Y_U_""""_Y_""""
 ;
 ; date values
 I TYPE["D" D  Q
 .S DIR(0)="DAO^:DT:EX",DIR("A")="Date: "
 .S DIR("?",1)="Enter the date to be used in the search."
 .S DIR("??")="FSC U1 NOIS"
 .I $P(COND,U,3)["range" D  Q
 ..S DIR("A")="First Date: " D ^DIR Q:$D(DTOUT)  Q:$D(DUOUT)  S VALUE1=Y,VALUE=VALUE1_U_$$FMTE^XLFDT(VALUE1)_" to "
 ..S DIR("A")="Last Date: " D ^DIR Q:$D(DTOUT)  Q:$D(DUOUT)  S VALUE2=Y
 ..S:VALUE1>VALUE2 X=VALUE1,VALUE1=VALUE2,VALUE2=X
 ..S VALUE=VALUE1_"-"_VALUE2_U_$$FMTE^XLFDT(VALUE1)_" to "_$$FMTE^XLFDT(VALUE2)
 .D ^DIR
 .S VALUE=Y_U_$$FMTE^XLFDT(Y)
 ;
 ; numeric values
 I TYPE["N" D  Q
 .S DIR(0)="NOA^0:999:2",DIR("A")="Number: "
 .S DIR("?",1)="Enter a numeric value to be used in the search."
 .S DIR("?",2)="The number may include two decimal places"
 .S DIR("??")="FSC U1 NOIS"
 .I $P(COND,U,3)["range" D  Q
 ..S DIR("A")="First Number: " D ^DIR Q:$D(DTOUT)  Q:$D(DUOUT)  S VALUE1=Y,VALUE=VALUE1_U_VALUE1_" to "
 ..S DIR("A")="Last Number: " D ^DIR Q:$D(DTOUT)  Q:$D(DUOUT)  S VALUE2=Y
 ..S:VALUE1>VALUE2 X=VALUE1,VALUE1=VALUE2,VALUE2=X
 ..S VALUE=VALUE1_"-"_VALUE2_U_VALUE1_" to "_VALUE2
 .D ^DIR
 .S VALUE=+Y_U_Y
 ;
 ; pointer values
 I TYPE["P" D  Q
 .S DIC=+$P(TYPE,"P",2),DIC(0)="EMOQZ",DIC("A")="Select "_$P(FIELD,U,2)_": "
 .I $L($G(^FSC("FLD",+FIELD,.1))) S DIC("S")=^(.1)
 .S DIR("?",1)="Select the value of the field."
 .D LOOK^FSCQU(.DIC,.DIR)
 .S VALUE=+Y_U_$G(Y(0,0))
 Q
