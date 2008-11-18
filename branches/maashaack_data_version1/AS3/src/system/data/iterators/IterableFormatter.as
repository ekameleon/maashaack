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

package system.data.iterators 
{
    import system.data.Iterable;
    import system.data.Iterator;
    import system.formatters.Formattable;    

    /**
     * Converts an Iterable object to a custom string representation.
     */
    public class IterableFormatter implements Formattable 
    {

        /**
         * Creates a new IterableFormatter instance.
         */
        public function IterableFormatter()
        {
            //  
        }

        /**
         * Formats the specified value.
         * @param value The object to format.
         * @return the string representation of the formatted value. 
         */
        public function format( value:* = null ):String
        {
			if ( value != null && value is Iterable )
			{
				var r:String = "{";
				var it:Iterator = (value as Iterable).iterator() ; 
				while(it.hasNext())
				{
					r += it.next() ;
					if ( it.hasNext() )
					{
						r += "," ;
					}
				}
				r += "}";
				return r ;
			}
			else 
			{
				return "" ;
			}
        }
    }
}
