YTNEOPI2 ;ALB/ASF-NEO PI-R LAYMANS REPORT ;7/28/95  12:47 ;
 ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
1 ;control
 D DTA^YTREPT W !,?30,"Your NEO Summary",!
 F I=1:1:19 W !,^YTT(601,YSTEST,"G",1,1,I,0)
 D:IOST?1"C".E SCR^YTREPT Q:YSLFT
 S YSLN="",$P(YSLN,"_",79)="",H="|"
 W !?1,YSLN,!,?1,H,?78,H
 W !?1,H,?5,"COMPARED WITH THE RESPONSES OF OTHER PEOPLE, YOUR RESPONSES SUGGEST",?78,H
 W !?1,H,?20,"THAT YOU CAN BE DESCRIBED AS:",?78,H
 D VL
NF ;
 S I=31 D CK
 W !?1,H," ",V1,?6,"Sensitive, emotional",?30,V2,?32,"Generally calm and",?56,V3,?58,"Secure, hardy, and",?78,H
 W !?1,H,?6,"and prone to",?32,"able to deal with",?58,"generally relaxed",?78,H
 W !?1,H,?6,"experience feelings",?32,"stress, but you",?58,"even under stress-",?78,H
 W !?1,H,?6,"that are upsetting.",?32,"sometimes experience",?58,"ful conditions.",?78,H
 W !?1,H,?32,"feelings of guilt,",?78,H
 W !?1,H,?32,"anger or sadness.",?78,H
 D VL
EF ;
 S I=32 D CK
 W !?1,H," ",V1,?6,"Extraverted, outgoing",?30,V2,?32,"Moderate in activity",?56,V3,?58,"Introverted,reserved",?78,H
 W !?1,H,?6,"active and high-",?32,"and enthusiasm.",?58,"and serious.",?78,H
 W !?1,H,?6,"spirited. You prefer",?32,"You enjoy the",?58,"You prefer to be",?78,H
 W !?1,H,?6,"to be around people",?32,"company of others",?58,"alone or with a few",?78,H
 W !?1,H,?6,"most of the time.",?32,"but you also",?58,"close friends.",?78,H
 W !?1,H,?32,"value privacy.",?78,H
 D VL
OF ;
 S I=33 D CK
 W !?1,H," ",V1,?6,"Open to new",?30,V2,?32,"Practical but willing",?56,V3,?58,"Down-to-earth,",?78,H
 W !?1,H,?6,"experiences. You have",?32,"to consider new",?58,"practical,",?78,H
 W !?1,H,?6,"broad interests and",?32,"ways of doing things.",?58,"traditional and",?78,H
 W !?1,H,?6,"are very imaginative.",?32,"You seek a balance",?58,"pretty much set",?78,H
 W !?1,H,?32,"between the old and",?58,"in your ways.",?78,H
 W !?1,H,?32,"the new.",?78,H
 D VL
AF ;
 S I=34 D CK
 W !?1,H," ",V1,?6,"Compassionate, good-",?30,V2,?32,"Generally warm,",?56,V3,?58,"Hardheaded,",?78,H
 W !?1,H,?6,"natured, and eager",?32,"trusting and agreeable,",?58,"skeptical, proud",?78,H
 W !?1,H,?6,"to cooperate and",?32,"but you can",?58,"and competitive.",?78,H
 W !?1,H,?6,"avoid conflict.",?32,"sometimes be stubborn",?58,"You tend to express",?78,H
 W !?1,H,?32,"and competitive.",?58,"your anger directly.",?78,H
 D VL
CF ;
 S I=35 D CK
 W !?1,H," ",V1,?6,"Conscientious and",?30,V2,?32,"Dependable and",?56,V3,?58,"Easygoing, not very",?78,H
 W !?1,H,?6,"well-organized. You",?32,"moderately well-",?58,"well-organized, and",?78,H
 W !?1,H,?6,"have high standards",?32,"organized, You",?58,"sometimes careless.",?78,H
 W !?1,H,?6,"and always strive",?32,"generally have clear",?58,"You prefer not to",?78,H
 W !?1,H,?6,"to achieve your goals.",?32,"goals but are able to",?58,"make plans.",?78,H
 W !?1,H,?32,"set your work aside.",?78,H
 D VL
 W !!,"Copyright (c) 1985, 1988, 1992, 1994 by Psychological Assessment Resources Inc.",!,"Reproduced by permission."
 Q
VL W !?1,H,$E(YSLN,1,76),H Q
CK ;CHECK MARK
 S V=$P(S,U,I) I V>55 S V1="X",V2="_",V3="_" Q
 I V<45 S V1="_",V2="_",V3="X" Q
 S V1="_",V2="X",V3="_"
 Q
