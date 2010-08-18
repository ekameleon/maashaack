﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at  http://www.mozilla.org/MPL/    Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the  License.    The Original Code is [maashaack framework].    The Initial Developers of the Original Code are  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.  Portions created by the Initial Developers are Copyright (C) 2006-2010  the Initial Developers. All Rights Reserved.    Contributor(s):    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.*/package examples{    import core.maths.berp;
    import core.maths.round;
    import core.strings.padRight;        import flash.display.Shape;    import flash.display.Sprite;    import flash.display.StageScaleMode;    import flash.geom.Point;        [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]    
    public class berpExample extends Sprite
    {
        public function berpExample()        {            trace( berp( 0.00 , 0 , 100 ) ) ; // 0            trace( berp( 0.25 , 0 , 100 ) ) ; // 66.333670901566            trace( berp( 0.50 , 0 , 100 ) ) ; // 105.1015801865505            trace( berp( 0.75 , 0 , 100 ) ) ; // 98.63451414512325            trace( berp( 1.00 , 0 , 100 ) ) ; // 100                        trace("-----") ;                        stage.scaleMode = StageScaleMode.NO_SCALE ;                        var origin:Point = new Point( 740 / 2 , 480 / 2 ) ;            var pos:Point    = new Point() ;                        var spot:Shape ;                        for( var i:Number = 0 ; i<=1 ; i = round( i + 0.1 , 1 )  )             {                pos.x = i ;                pos.y = berp( i , 0 , 100 ) ;                                trace( padRight( String(pos.x) , 3 )  + " : " + pos.y ) ;                                spot = new Shape() ;                                spot.graphics.beginFill( 0x000000 ) ;                spot.graphics.drawRect( -3 , -3, 6 , 6 ) ;                                spot.x = origin.x + pos.x * 10 * 20 ;                spot.y = origin.y - pos.y ;                                addChild( spot ) ;            }        }    }}