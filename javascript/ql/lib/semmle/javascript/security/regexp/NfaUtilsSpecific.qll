/**
 * Provides JavaScript-specific definitions for use in the NfaUtils module.
 */

import javascript

/**
 * Holds if `term` is an ecape class representing e.g. `\d`.
 * `clazz` is which character class it represents, e.g. "d" for `\d`.
 */
predicate isEscapeClass(RegExpTerm term, string clazz) {
  exists(RegExpCharacterClassEscape escape | term = escape | escape.getValue() = clazz)
}

/**
 * Holds if `term` is a possessive quantifier.
 * As javascript's regexes do not support possessive quantifiers, this never holds, but is used by the shared library.
 */
predicate isPossessive(RegExpQuantifier term) { none() }

/**
 * Holds if the regex that `term` is part of is used in a way that ignores any leading prefix of the input it's matched against.
 * Not yet implemented for Javascript.
 */
predicate matchesAnyPrefix(RegExpTerm term) { any() }

/**
 * Holds if the regex that `term` is part of is used in a way that ignores any trailing suffix of the input it's matched against.
 * Not yet implemented for Javascript.
 */
predicate matchesAnySuffix(RegExpTerm term) { any() }

/**
 * Holds if the regular expression should not be considered.
 *
 * For javascript we make the pragmatic performance optimization to ignore minified files.
 */
predicate isExcluded(RegExpParent parent) { parent.(Expr).getTopLevel().isMinified() }

/**
 * A module containing predicates for determining which flags a regular expression have.
 */
module RegExpFlags {
  /**
   * Holds if `root` has the `i` flag for case-insensitive matching.
   */
  predicate isIgnoreCase(RegExpTerm root) { RegExp::isIgnoreCase(getFlags(root)) }

  /**
   * Gets the flags for `root`, or the empty string if `root` has no flags.
   */
  string getFlags(RegExpTerm root) {
    root.isRootTerm() and
    exists(DataFlow::RegExpCreationNode node | node.getRoot() = root |
      result = node.getFlags()
      or
      not exists(node.getFlags()) and
      result = ""
    )
    or
    exists(RegExpPatternSource source | source.getRegExpTerm() = root |
      result = source.getARegExpObject().(DataFlow::RegExpCreationNode).getFlags()
    )
  }

  /**
   * Holds if `root` has the `s` flag for multi-line matching.
   */
  predicate isDotAll(RegExpTerm root) { RegExp::isDotAll(getFlags(root)) }
}
