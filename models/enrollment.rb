require_relative('../db/sql_runner')

class Enrollment

    attr_reader(:id, :member_id, :gym_class_id)

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @member_id = options['member_id'].to_i
        @gym_class_id = options['gym_class_id'].to_i
    end

    def save()
        sql = "INSERT INTO enrollments
        (member_id, gym_class_id)
        VALUES
        ($1, $2)
        RETURNING id"
        values = [@member_id, @gym_class_id]
        result = SqlRunner.run(sql, values)
        @id = result.first()['id'].to_i
    end

end