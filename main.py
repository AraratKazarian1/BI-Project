from pipeline_relational_data.flow import RelationalDataFlow
from pipeline_dimensional_data.flow import DimensionalDataFlow

if __name__ == '__main__':
    rel_data_flow_instance = RelationalDataFlow()
    rel_data_flow_instance.exec()

    dim_data_flow_instance = DimensionalDataFlow()
    dim_data_flow_instance.exec()