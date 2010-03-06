﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at  http://www.mozilla.org/MPL/    Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the  License.    The Original Code is [maashaack framework].    The Initial Developers of the Original Code are  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.  Portions created by the Initial Developers are Copyright (C) 2006-2010  the Initial Developers. All Rights Reserved.    Contributor(s):    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.*/package system.process {    /**     * A chain is a sequence with a finite or infinite number of actions. All actions registered in the chain can be executed one by one with different strategies (loop, auto remove, etc).     * <p><b>Example :</b></p>     * <pre class="prettyprint">     * package examples     * {     *     import system.events.ActionEvent;     *     import system.process.Action;     *     import system.process.Chain;     *     import system.process.Pause;     *          *     import flash.display.Sprite;     *          *     [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]     *          *     public class ChainBasicExample extends Sprite     *     {     *         public function ChainBasicExample()     *         {     *             var chain:Chain = new Chain() ;     *                  *             chain.addEventListener( ActionEvent.FINISH   , debug ) ;     *             chain.addEventListener( ActionEvent.PROGRESS , debug ) ;     *             chain.addEventListener( ActionEvent.START    , debug ) ;     *                  *             chain.finishIt.connect( finish ) ;     *             chain.progressIt.connect( progress ) ;     *             chain.startIt.connect( start  ) ;     *                  *             chain.addAction( new Pause(1) ) ;     *             chain.addAction( new Pause(1) ) ;     *             chain.addAction( new Pause(1) ) ;     *                  *             chain.run() ;     *         }     *              *         public function debug( e:ActionEvent ):void     *         {     *             trace( "debug " + e.type ) ;     *         }     *              *         public function finish( action:Action ):void     *         {     *             trace( "finish" ) ;     *         }     *              *         public function progress( action:Action ):void     *         {     *             trace( "progress : " + (action as Chain).current ) ;     *         }     *              *         public function start( action:Action ):void     *         {     *             trace( "start" ) ;     *         }     *     }     * }     * </pre>     */    public class Chain extends CoreAction implements Resumable, Startable, Stoppable    {        /**         * Creates a new Chain instance.         * @param length The initial length (number of elements) of the Vector. If this parameter is greater than zero, the specified number of Vector elements are created and populated with the default value appropriate to the base type (null for reference types).         * @param fixed Whether the chain length is fixed (true) or can be changed (false). This value can also be set using the fixed property.         * @param loop Specifies whether playback of the clip should continue, or loop (default false).          * @param numLoop Specifies the number of the times the presentation should loop during playback.         * @param mode Specifies the mode of the chain. The mode can be "normal" (default), "transient" or "everlasting".         * @param actions A dynamic object who contains Action references to initialize the chain.         */        public function Chain( length:uint = 0 , fixed:Boolean = false , loop:Boolean = false , numLoop:uint = 0 , mode:String = "normal" , actions:* = null )        {            _chain       = new Vector.<ActionEntry>( length , fixed ) ;            this.loop    = loop ;            this.mode    = mode ;            this.numLoop = numLoop ;            if ( actions )            {                for each( var action:* in actions )                {                    addAction( action as Action ) ;                }            }        }                /**         * Determinates the "everlasting" mode of the chain. In this mode the action register in the chain can be auto-remove.         */        public static const EVERLASTING:String = "everlasting" ;                /**         * Determinates the "normal" mode of the chain. In this mode the chain has a normal life cycle.         */        public static const NORMAL:String = "normal" ;                /**         * Determinates the "transient" mode of the chain. In this mode all actions are strictly auto-remove in the chain when are invoked.         */        public static const TRANSIENT:String = "transient" ;                /**         * Indicates the current Action reference when the chain process is running.         */        public function get current():Action        {            return _current ? _current.action : null ;        }                /**         * Indicates the current countdown loop value.         */        public function get currentLoop():uint        {            return _currentLoop ;        }                /**         * Indicates whether the chain length is fixed (true) or can be changed (false). This value can also be set using the fixed property.         */        public function get fixed():Boolean        {            return _chain.fixed ;        }                /**         * @private         */        public function set fixed( bool:Boolean ):void        {            _chain.fixed = bool ;        }                /**         * Indicates the numbers of actions in the chain.         */        public function get length():uint        {            return _chain.length ;        }                /**         * @private         */        public function set length( value:uint ):void        {            dispose() ;            var old:uint  = _chain.length ;            _chain.length = value ;            _current      = null ;            var l:int = _chain.length ;            if ( l > 0 )            {                var e:ActionEntry ;                while( --l > -1 )                {                    e = _chain[l] as ActionEntry ;                    if ( e && e.action )                    {                        e.action.finishIt.connect( next ) ;                    }                }            }            else if ( !isLocked() && old > 0 )             {                 notifyCleared() ; // clear notification            }        }                /**         * Specifies whether playback of the chain should continue, or loop.          * See the numLoop property to defines the number of times the chain should be looping.          */        public var loop:Boolean ;                /**         * Determinates the mode of the chain. The mode can be "normal", "transient" or "everlasting".         * @see Chain.NORMAL, Chain.EVERLASTING, Chain.TRANSIENT         */        public function get mode():String        {            return _mode ;        }                /**         * @private         */        public function set mode( value:String ):void        {            _mode = ( value == TRANSIENT || value == EVERLASTING ) ? value : NORMAL ;        }                /**         * Specifies the number of the times the chain should loop during playback.         */        public var numLoop:uint ;                /**         * Indicates the current numeric position of the chain.         */        public function get position():uint        {            return _position ;        }                /**         * Indicates if the chain is stopped.         */        public function get stopped():Boolean        {            return _stopped ;        }                /**         * Insert an action in thechainr.         * @param priority Determinates the priority level of the action in the chain.         * @param autoRemove Apply a removeAction after the first finish notification.         * @return <code class="prettyprint">true</code> if the insert is success.         */        public function addAction( action:Action , priority:uint = 0 , autoRemove:Boolean = false ):Boolean         {            if ( action )            {                action.finishIt.connect( next ) ;                _chain.push( new ActionEntry( action , priority , autoRemove ) ) ;                shellSort(_chain) ;                return true ;            }            return false ;        }                /**         * Returns a shallow copy of this object.         * @return a shallow copy of this object.         */        public override function clone():*        {            var clone:Chain = new Chain( 0 , false , loop , numLoop , _mode, _chain.length > 0 ? toVector() : null ) ;            clone.fixed = _chain.fixed ;            return clone ;        }                /**         * Dispose the chain and disconnect all actions but don't remove them.         */        public function dispose():void        {            var l:int = _chain.length ;            if ( l > 0 )            {                var e:ActionEntry ;                while( --l > -1 )                {                    e = _chain[l] as ActionEntry ;                    if ( e && e.action )                    {                        e.action.finishIt.disconnect( next ) ;                    }                }            }        }                /**         * Retrieves the next action reference in the chain with the current position.         */        public function element():*         {            return _chain.length > 0 ? (_chain[_position] as ActionEntry).action : null ;        }                /**         * Returns the action register in the chain at the specified index value or <code>null</code>.         * @return the action register in the chain at the specified index value or <code>null</code>.         */        public function getActionAt( index:uint ):Action         {            if ( _chain.length > 0 && index < _chain.length )            {                return (_chain[index] as ActionEntry).action ;            }            return null ;        }                /**         * Returns <code class="prettyprint">true</code> if the specified Action is register in the chain.         * @return <code class="prettyprint">true</code> if the specified Action is register in the chain.         */        public function hasAction( action:Action ):Boolean        {            if ( action )            {                if ( _chain.length > 0 )                {                    var e:ActionEntry ;                    var l:int = _chain.length ;                    while( --l > -1 )                    {                        e = _chain[l] as ActionEntry ;                        if ( e && e.action == action )                        {                            return true ;                        }                    }                }            }            return false ;        }                /**         * Returns <code>true</code> if the chain is empty.         * @return <code>true</code> if the chain is empty.         */        public function isEmpty():Boolean        {            return _chain.length == 0 ;        }                /**         * Remove a specific action register in the chain and if the passed-in argument is null all actions register in the chain are removed.          * If the chain is running the stop() method is called.         * @return <code class="prettyprint">true</code> if the method success.         */        public function removeAction( action:Action = null ):Boolean         {            stop() ;            if ( _chain.length > 0 )            {                if ( action )                {                    var e:ActionEntry ;                    var l:int = _chain.length ;                    while( --l > -1 )                    {                        e = _chain[l] as ActionEntry ;                        if ( e && e.action == action )                        {                            action.finishIt.disconnect( next ) ;                            _chain.splice( l , 1 ) ;                            return true ;                        }                    }                }                else                {                    dispose() ;                    _chain.length = 0 ;                    if ( !isLocked() )                     {                        notifyCleared() ;                    }                    return true ;                }            }            return false ;        }                /**         * Resume the chain.         */        public function resume():void         {            if ( _stopped )            {                setRunning(true) ;                _stopped = false ;                if ( !isLocked() )                {                    notifyResumed() ;                }                if ( _current && _current.action && _current.action is Resumable )                {                    (_current.action as Resumable).resume() ;                }                else                {                    next() ;                }             }            else            {                run() ;             }        }                /**         * Launchs the chain process.         */        public override function run( ...arguments:Array ):void         {            if ( !running )            {                notifyStarted() ;                _current     = null  ;                _stopped     = false ;                _position    = 0 ;                _currentLoop = 0 ;                next() ;            }        }                /**         * Sets the internal chain.         * @param length The initial length (number of elements) of the Vector. If this parameter is greater than zero, the specified number of Vector elements are created and populated with the default value appropriate to the base type (null for reference types).         * @param fixed Whether the chain length is fixed (true) or can be changed (false). This value can also be set using the fixed property.         */        public function setup( length:uint = 0, fixed:Boolean = false ):void        {             _chain.length = length ;             _chain.fixed  = fixed ;        }                /**         * Starts the chain.         */        public function start():void         {            run() ;        }                /**         * Stops the chain. Stop only the current action if is running.         */        public function stop():void        {            if ( running )             {                stopCurrent() ;                setRunning(false) ;                _stopped = true ;                if ( !isLocked() )                {                    notifyStopped() ;                }            }        }                /**         * Returns the Array representation of the chain.         * @return the Array representation of the chain.         */        public function toArray():Array        {            if ( _chain.length > 0 )            {                var i:int ;                var e:ActionEntry ;                var r:Array = [] ;                var l:int = _chain.length ;                for( i ; i<l ; i++ )                {                    e = _chain[i] as ActionEntry ;                    if ( e && e.action )                    {                        r[r.length] = e.action ;                    }                }                return r ;            }            else            {                return [] ;            }        }                /**         * Returns the String representation of the object.         * @return the String representation of the object.         */        public function toString( verbose:Boolean = false ):String        {            if ( verbose )            {                var s:String = "[Chain <" ;                if ( _chain.length > 0 )                {                    var i:int ;                    var e:ActionEntry ;                    var l:int = _chain.length ;                    var r:Vector.<Action> = new Vector.<Action>() ;                    for( i ; i<l ; i++ )                    {                        e = _chain[i] as ActionEntry ;                        r[r.length] = ( e && e.action ) ? e.action : null ;                    }                    s += r.toString() ;                }                s += ">]" ;                return s ;            }            else            {                return"[Object Chain]" ;             }        }                /**         * Returns the Vector (of Action) representation of the chain.         * @return the Vector (of Action) representation of the chain.         */        public function toVector( fixed:Boolean = false ):Vector.<Action>        {            if ( _chain.length > 0 )            {                var i:int ;                var e:ActionEntry ;                var l:int = _chain.length ;                var r:Vector.<Action> = new Vector.<Action>() ;                for( i ; i<l ; i++ )                {                    e = _chain[i] as ActionEntry ;                    if ( e && e.action )                    {                        r[r.length] = e.action ;                    }                }                return r ;            }            else            {                return new Vector.<Action>() ;            }        }                /**         * @private         */        internal var _chain:Vector.<ActionEntry> ;                /**         * @private         */        internal var _current:ActionEntry ;                /**         * @private         */        internal var _position:int ;                /**         * @private         */        internal var _stopped:Boolean ;                /**         * Indicates if the chain contains a next action during the process.         */        internal function hasNext():Boolean        {            return _position < _chain.length ;        }                /**         * Run the next action in the chain.         */        internal function next( ...args:Array ):void         {            if ( _current && _mode != EVERLASTING )            {                if ( _mode == TRANSIENT || (_current.auto && _mode == NORMAL) )                {                    _current.action.finishIt.disconnect( next ) ;                    _position -- ;                    _chain.splice( _position , 1 ) ;                }            }            _current = null ;            if ( _chain.length > 0 )             {                if ( hasNext() )                {                    _current = _chain[_position++] as ActionEntry ;                    notifyProgress() ;                    if ( _current && _current.action )                    {                        _current.action.run() ;                    }                    else                    {                        next() ;                    }                }                else if ( loop )                {                    _position = 0 ;                    if( numLoop == 0 )                    {                        notifyLooped() ;                        _currentLoop = 0  ;                        next() ;                    }                    else if ( _currentLoop < numLoop )                    {                        _currentLoop ++ ;                        notifyLooped() ;                        next() ;                    }                    else                    {                        _currentLoop = 0 ;                        notifyFinished() ;                     }                }                else                {                    _currentLoop = 0 ;                    _position    = 0 ;                    notifyFinished() ;                }            }            else             {                notifyFinished() ;            }        }                /**         * Stop the current action in the chain.         */        internal function stopCurrent():void        {            if ( _current && _current.action )            {                if ( _current.action is Stoppable )                {                    (_current.action as Stoppable).stop() ;                }            }        }                /**         * @private         */        protected var _currentLoop:uint ;                /**         * @private         */        protected var _mode:String ;                /**         * Use a shell sort algorithm to sort the Vector of ActionEntry (http://en.wikipedia.org/wiki/Shell_sort). The sort method with a basic PriorityComparator.compare method failed ?         * @private         */        protected function shellSort( data:Vector.<ActionEntry> ):void         {            if( data )            {                var temp:ActionEntry ;                var i:int ;                var j:int ;                var l:int = data.length ;                var inc:int = int( l / 2 + 0.5 ) ;                while( inc )                 {                    for( i = inc ; i<l ; i++ )                     {                        temp = data[i] ;                         j    = i ;                        while( j >= inc && data[int(j - inc)].priority < temp.priority )                         {                            data[j] = data[int(j - inc)] ;                            j = int(j - inc);                        }                        data[j] = temp ;                    }                    inc = int(inc / 2.2 + 0.5);                }            }        }    }}