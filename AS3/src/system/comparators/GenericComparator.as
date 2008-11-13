﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2008
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.comparators
{
    import system.Comparator;                                        

    /**
	 * This comparator compare two Objects by field.
	 * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.comparators.GenericComparator ;
     * import system.comparators.StringComparator ;
     * 
     * var write:Function = function( ar:Array ):void
     * {
     *     var result:Array = [] ;
     *     var size:uint = ar.length ;
     *     for (var i:uint = 0 ; i<size ; i++)
     *     {
     *         result[i] = ar[i].label ;
     *     }
     *     trace( result.join('|') ) ;
     * }
     * 
     * var ar:Array =
     * import system.comparators.GenericComparator ;
     * import system.comparators.StringComparator ;
     * 
     * var write:Function = function( ar:Array ):void
     * {
     *     var result:Array = [] ;
     *     var size:uint = ar.length ;
     *     for (var i:uint = 0 ; i<size ; i++)
     *     {
     *         result[i] = ar[i].label ;
     *     }
     *     trace( result.join('|') ) ;
     * }
     * 
     * var ar:Array =
     * [
     *     { id : 0 , label : "Paris"     } ,
     *     { id : 0 , label : "Marseille" } ,
     *     { id : 0 , label : "Lyon"      } ,
     *     { id : 0 , label : "Bordeaux"  }
     * ] ;
     * 
     * var c:GenericComparator = new GenericComparator( "label", StringComparator.getStringComparator() ) ;
     * 
     * ar.sort( c.compare , Array.CASEINSENSITIVE ) ;
     * write(ar) ; // Lyon|Paris|Bordeaux|Marseille
     * 
     * ar.sort( c.compare , Array.CASEINSENSITIVE | Array.DESCENDING ) ;
     * write(ar) ; // Paris|Marseille|Lyon|Bordeaux
     * </pre>
     */
	public class GenericComparator implements Comparator
	{
		
		/**
		 * Creates a new GenericComparator instance.
	     * @param sortBy A String who represents a property name to compare the two objects.
	     * @param comparator An Comparator use to compare the two objects with the specified property names. 
	     * @throws ArgumentError If the 'sortBy' argument is 'null'.
	     * @throws ArgumentError If the 'comparator' argument is 'null'.		 
	     */
		public function GenericComparator( sortBy:String , comparator:Comparator )
		{
			if ( sortBy != null  )
			{
				this.sortBy = sortBy ;
			}
			else
			{
				throw new ArgumentError(this + " constructor failed, the 'sortBy' argument not must be 'null' or 'undefined'.") ;
			}
			
			if ( comparator != null )
			{
				this.comparator = comparator ;
			}
			else
			{
				throw new ArgumentError( this + " constructor failed, the 'comparator' argument not must be 'null' or 'undefined'.") ;	
			}
		}

		/**
		 * The internal Comparator used by this Comparator to compare two objects with the specified field.
		 */
		public var comparator:Comparator ;
		
		/**
	     * A String who represents a property name to compare the two objects.
	     */
		public var sortBy:String;
        
		/**
		 * Returns an integer value to compare two objects.
		 * @param o1 the first Number object to compare.
		 * @param o2 the second Number object to compare.
	     * @return <p>
	     * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
	     * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
	     * <li> 0 if o1 and o2 are equal.</li>
	     * </p>
	     * @throws ArgumentError if the two arguments are null.
	     */
		public function compare(o1:*, o2:*, options:* = null):int
		{
			if ( o1 != null && o2 != null ) 
			{
				if ( comparator == null )
				{
					throw new Error( "GenericComparator failed, the 'comparator' argument not must be 'null' or 'undefined'.") ;
				}
				else
				{
					return comparator.compare( o1[sortBy] , o2[sortBy] , options ) ;
				}
			}
			else 
			{
				throw new ArgumentError( "The GenericComparator.compare method failed, The two arguments not must be null.") ;
			}
		}
        		
	}
}