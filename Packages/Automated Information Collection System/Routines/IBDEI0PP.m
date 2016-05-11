IBDEI0PP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12015,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,12015,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,12016,0)
 ;;=Z63.5^^47^538^155
 ;;^UTILITY(U,$J,358.3,12016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12016,1,3,0)
 ;;=3^Problems Related to Separation/Divorce
 ;;^UTILITY(U,$J,358.3,12016,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,12016,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,12017,0)
 ;;=Z55.9^^47^538^132
 ;;^UTILITY(U,$J,358.3,12017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12017,1,3,0)
 ;;=3^Problems Related to Education/Literacy,Unspec
 ;;^UTILITY(U,$J,358.3,12017,1,4,0)
 ;;=4^Z55.9
 ;;^UTILITY(U,$J,358.3,12017,2)
 ;;=^5063106
 ;;^UTILITY(U,$J,358.3,12018,0)
 ;;=Z56.9^^47^538^133
 ;;^UTILITY(U,$J,358.3,12018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12018,1,3,0)
 ;;=3^Problems Related to Employment,Unspec
 ;;^UTILITY(U,$J,358.3,12018,1,4,0)
 ;;=4^Z56.9
 ;;^UTILITY(U,$J,358.3,12018,2)
 ;;=^5063117
 ;;^UTILITY(U,$J,358.3,12019,0)
 ;;=Z65.5^^47^538^130
 ;;^UTILITY(U,$J,358.3,12019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12019,1,3,0)
 ;;=3^Problems Related to Disaster/War/Other Hostilities
 ;;^UTILITY(U,$J,358.3,12019,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,12019,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,12020,0)
 ;;=Z59.5^^47^538^134
 ;;^UTILITY(U,$J,358.3,12020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12020,1,3,0)
 ;;=3^Problems Related to Extreme Poverty
 ;;^UTILITY(U,$J,358.3,12020,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,12020,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,12021,0)
 ;;=Z59.0^^47^538^136
 ;;^UTILITY(U,$J,358.3,12021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12021,1,3,0)
 ;;=3^Problems Related to Homelessness
 ;;^UTILITY(U,$J,358.3,12021,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,12021,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,12022,0)
 ;;=Z59.9^^47^538^137
 ;;^UTILITY(U,$J,358.3,12022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12022,1,3,0)
 ;;=3^Problems Related to Housing/Economic Circumstances
 ;;^UTILITY(U,$J,358.3,12022,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,12022,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,12023,0)
 ;;=Z59.1^^47^538^138
 ;;^UTILITY(U,$J,358.3,12023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12023,1,3,0)
 ;;=3^Problems Related to Inadequate Housing
 ;;^UTILITY(U,$J,358.3,12023,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,12023,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,12024,0)
 ;;=Z59.7^^47^538^139
 ;;^UTILITY(U,$J,358.3,12024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12024,1,3,0)
 ;;=3^Problems Related to Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,12024,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,12024,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,12025,0)
 ;;=Z59.4^^47^538^140
 ;;^UTILITY(U,$J,358.3,12025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12025,1,3,0)
 ;;=3^Problems Related to Lack of Food/Drinking Water
 ;;^UTILITY(U,$J,358.3,12025,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,12025,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,12026,0)
 ;;=Z73.9^^47^538^141
 ;;^UTILITY(U,$J,358.3,12026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12026,1,3,0)
 ;;=3^Problems Related to Life Management Difficulty
 ;;^UTILITY(U,$J,358.3,12026,1,4,0)
 ;;=4^Z73.9
 ;;^UTILITY(U,$J,358.3,12026,2)
 ;;=^5063281
 ;;^UTILITY(U,$J,358.3,12027,0)
 ;;=Z72.9^^47^538^142
 ;;^UTILITY(U,$J,358.3,12027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12027,1,3,0)
 ;;=3^Problems Related to Lifestyle
 ;;^UTILITY(U,$J,358.3,12027,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,12027,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,12028,0)
 ;;=Z73.6^^47^538^124
