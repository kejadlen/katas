require 'parslet'
require 'pry'

require_relative 'simple'

class SimpleParser < Parslet::Parser
  root :statement
  rule(:statement) { while_ | assign }
  rule(:while_) { ( str('while (') >>
                    expression.as(:condition) >>
                    str(') { ') >>
                    statement.as(:body) >>
                    str(' }')
                  ).as(:while) }
  rule(:assign) { ( match['a-z'].repeat(1).as(:name) >>
                    str(' = ') >>
                    expression.as(:expression)
                  ).as(:assign) }
  rule(:expression) { less_than }
  rule(:less_than) { ( multiply.as(:left) >>
                       str(' < ') >>
                       less_than.as(:right)
                     ).as(:less_than) |
                     multiply }
  rule(:multiply) { ( term.as(:left) >>
                      str(' * ') >> 
                      multiply.as(:right)
                    ).as(:multiply) |
                    term }
  rule(:term) { number | variable }
  rule(:number) { match['0-9'].repeat(1).as(:number) }
  rule(:variable) { match['a-z'].repeat(1).as(:variable) }
end

class SimpleTransform < Parslet::Transform
  rule(while: { condition: simple(:c), body: simple(:b) }) { While.new(c, b) }
  rule(assign: { name: simple(:n), expression: simple(:e) }) { Assign.new(n.to_sym, e) }
  rule(less_than: { left: simple(:l), right: simple(:r) }) { LessThan.new(l, r) }
  rule(multiply: { left: simple(:l), right: simple(:r) }) { Multiply.new(l, r) }
  rule(number: simple(:x)) { Number.new(x.to_i) }
  rule(variable: simple(:x)) { Variable.new(x.to_sym) }
end

parser = SimpleParser.new
tree = parser.parse('while (x < 5) { x = x * 3 }')
p tree

transform = SimpleTransform.new
ast = transform.apply(tree)
p ast

puts ast.to_ruby
p ast.evaluate(x: Number.new(1))
p eval(ast.to_ruby).call(x: 1)
