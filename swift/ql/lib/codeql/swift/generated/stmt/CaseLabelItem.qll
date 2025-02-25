// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.AstNode
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.pattern.Pattern

class CaseLabelItemBase extends Synth::TCaseLabelItem, AstNode {
  override string getAPrimaryQlClass() { result = "CaseLabelItem" }

  Pattern getImmediatePattern() {
    result =
      Synth::convertPatternFromRaw(Synth::convertCaseLabelItemToRaw(this)
            .(Raw::CaseLabelItem)
            .getPattern())
  }

  final Pattern getPattern() { result = getImmediatePattern().resolve() }

  Expr getImmediateGuard() {
    result =
      Synth::convertExprFromRaw(Synth::convertCaseLabelItemToRaw(this)
            .(Raw::CaseLabelItem)
            .getGuard())
  }

  final Expr getGuard() { result = getImmediateGuard().resolve() }

  final predicate hasGuard() { exists(getGuard()) }
}
