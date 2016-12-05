class CalculatorService
  def initialize
    @conn = ActiveRecord::Base.connection
  end

  def calculate_common_expenses(item_id)
    @conn.execute <<-SQL.gsub(/\s+/, ' ').strip
      SELECT ep.name, sum(ep.calculated_amount) AS amount FROM
      (SELECT u.name, sum(e.amount / e.number_of_participants) * -1 AS calculated_amount
      FROM items AS i
      INNER JOIN item_users AS iu ON i.id = iu.item_id
      INNER JOIN users AS u ON u.id = iu.user_id
      INNER JOIN expense_users AS eu ON eu.user_id = u.id
      INNER JOIN expenses AS e ON e.id = eu.expense_id

      WHERE i.id = #{item_id} and e.item_id = #{item_id}
      Group BY i.name, u.name

      UNION

      SELECT u.name, sum(p.amount)
      FROM items AS i
      INNER JOIN item_users AS iu ON i.id = iu.item_id
      INNER JOIN users AS u ON u.id = iu.user_id
      INNER JOIN payments AS p ON p.user_id = u.id

      WHERE i.id = #{item_id} and p.item_id = #{item_id}
      Group BY u.name
      ) AS ep
      GROUP BY ep.name

    SQL
  end
end
