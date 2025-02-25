// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.AstNode
import codeql.swift.elements.decl.Decl

class IfConfigDeclBase extends Synth::TIfConfigDecl, Decl {
  override string getAPrimaryQlClass() { result = "IfConfigDecl" }

  AstNode getImmediateActiveElement(int index) {
    result =
      Synth::convertAstNodeFromRaw(Synth::convertIfConfigDeclToRaw(this)
            .(Raw::IfConfigDecl)
            .getActiveElement(index))
  }

  final AstNode getActiveElement(int index) { result = getImmediateActiveElement(index).resolve() }

  final AstNode getAnActiveElement() { result = getActiveElement(_) }

  final int getNumberOfActiveElements() { result = count(getAnActiveElement()) }
}
