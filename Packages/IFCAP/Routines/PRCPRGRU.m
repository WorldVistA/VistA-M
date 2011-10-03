PRCPRGRU ;WISC/RFJ-get graph in variable                            ;09 Feb 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
GETGRAPH(HEADING,YHEADING,XHEADING,XCODE,BARCHART,AVGFZERO,DATA)   ;
 ;  return graph in variable yline 
 ;  heading=top of graph
 ;  yheading=yaxis heading
 ;  xheading=xaxis heading
 ;  xcode=mumps code to set label on xaxis
 ;  barchart=1 for barchart
 ;  avgfzero=1 to include zero values when calculating the average
 ;  data(xaxis)=value
 ;
 N %,AVERAGE,AVGCOUNT,AVGFLAG,AVGLINE,CHAR,COLUMN,COUNT,DATALINE,FRONT,INCREMEN,LASTLINE,LINE,MAXVALUE,SPACE,STEP,TOTAL,TOTLENGT,TOTVALUE,VALUE,X,XAXIS,Y
 S SPACE="                                                                                "
 S YHEADING=YHEADING_SPACE
 S MAXVALUE=0,TOTVALUE=0,AVGCOUNT=0
 S X="" F TOTAL=1:1 S X=$O(DATA(X)) Q:X=""  S COLUMN(TOTAL*5)=DATA(X)_"*^",TOTVALUE=TOTVALUE+DATA(X) S AVGCOUNT=$S('AVGFZERO&('DATA(X)):AVGCOUNT,1:AVGCOUNT+1) I DATA(X)>MAXVALUE S MAXVALUE=DATA(X)
 S AVERAGE="0.00" I AVGCOUNT S AVERAGE=$J(TOTVALUE/AVGCOUNT,0,2)
 S LASTLINE="",$P(LASTLINE,"+----",TOTAL+1)=""
 S INCREMEN=$J(MAXVALUE/6,0,2) I +INCREMEN=0 S INCREMEN=1
 ;  build array in yline
 S YLINE(1)="         ^          "_HEADING
 S YLINE(2)="         |"_$E(SPACE,1,69)
 S COUNT=2
 F LINE=6:-1:1 D
 .   D SETLINE(LINE)
 .   S FRONT=$E(YHEADING,COUNT-1)_$E($J(INCREMEN*LINE,7),1,7)_"-+"
 .   S COUNT=COUNT+1,YLINE(COUNT)=FRONT_$E(DATALINE,1,79)
 .   D SETLINE(LINE-.5)
 .   S FRONT=$E(YHEADING,COUNT-1)_"        |"
 .   S COUNT=COUNT+1,YLINE(COUNT)=FRONT_$E(DATALINE,1,79)
 S YLINE(COUNT)=$E(YLINE(COUNT),1,9)_LASTLINE_">",TOTLENGT=$L(YLINE(COUNT))
 S COUNT=COUNT+1,YLINE(COUNT)=$E($E(XHEADING,1,10)_SPACE,1,10)
 S YLINE(COUNT+1)=$E($E(XHEADING,11,20)_SPACE,1,10)
 S XAXIS="" F  S XAXIS=$O(DATA(XAXIS)) Q:XAXIS=""  S X=XAXIS K X(1) X:XCODE'="" XCODE S YLINE(COUNT)=YLINE(COUNT)_$E($J(X,5),1,5) I $D(X(1)) S YLINE(COUNT+1)=YLINE(COUNT+1)_$E($J(X(1),5),1,5)
 I $TR($G(YLINE(COUNT+1))," ")'="" S COUNT=COUNT+1
 S COUNT=COUNT+1,YLINE(COUNT)="              AVERAGE: "_AVERAGE
 I $G(AVGLINE) S YLINE(AVGLINE)=$E(YLINE(AVGLINE),1,10)_$E($TR($E(YLINE(AVGLINE),11,255)," -|^","===="),1,TOTLENGT-15)_" AVG"
 ;  remove trailing spaces
 S X=0 F  S X=$O(YLINE(X)) Q:'X  D
 .   F %=$L(YLINE(X)):-1,10 Q:$E(YLINE(X),%)'=" "
 .   S YLINE(X)=$E(YLINE(X),1,%)
 Q
 ;
 ;
SETLINE(STEP) ;  build line of display 
 ;  step=incerment on y-axis
 S DATALINE=$E(SPACE,1,69)
 F %=5:5 Q:'$D(COLUMN(%))  S VALUE=+COLUMN(%),CHAR=$P(COLUMN(%),"*",2) I VALUE'<(INCREMEN*STEP) D
 .   ; set value on top of previous line
 .   I CHAR="^" S X=$S($G(BARCHART):8,1:9),Y=X-1+%+$L(VALUE),YLINE(COUNT)=$E(YLINE(COUNT),0,X+%-1)_VALUE_$E(YLINE(COUNT),Y+1,200)
 .   S X="    "_CHAR I $G(BARCHART),CHAR="^" S X="-----"
 .   I $G(BARCHART),$E(DATALINE,%-5)=" " S DATALINE=$E(DATALINE,0,%-6)_$S(X["-":"-",1:"|")_$E(DATALINE,%-4,200)
 .   S DATALINE=$E(DATALINE,0,%-5)_X_$E(DATALINE,%-3,200),$P(COLUMN(%),"*",2)="|"
 I AVERAGE'<(INCREMEN*STEP),'$G(AVGFLAG) S AVGFLAG=1,AVGLINE=COUNT+1
 Q
