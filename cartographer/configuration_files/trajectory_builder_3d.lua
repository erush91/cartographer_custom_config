-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

MAX_3D_RANGE = 100.
  -- SET BASED UPON OUSTER LIMITATIONS
  -- IMPACT: HAS NOT BEEN EVALUATED, NEED TO TEST EFFECT ON LATENCY AND ACCURACY

TRAJECTORY_BUILDER_3D = {
  min_range = 0.5,
  -- SET BASED UPON OUSTER LIMITATIONS
  -- IMPACT: HAS NOT BEEN EVALUATED, NEED TO TEST EFFECT ON LATENCY AND ACCURACY
  max_range = MAX_3D_RANGE,
  num_accumulated_range_data = 1,
  voxel_filter_size = 0.15,

  high_resolution_adaptive_voxel_filter = {
    max_length = 2.,
    min_num_points = 150,
    max_range = 15.,
  },

  low_resolution_adaptive_voxel_filter = {
    max_length = 4.,
    min_num_points = 200,
    max_range = MAX_3D_RANGE,
  },

  use_online_correlative_scan_matching = false,
  real_time_correlative_scan_matcher = {
    linear_search_window = 0.11,
    -- IMPACT: SET BASED ON 1 M/S MAX SPEED, TRACKING ERROR IF VEHICLES GOES FASTER
    angular_search_window = math.rad(1.),
    -- ISSUE: UNRESOLVABLE LATENCY WHEN INCREASING ABOVE 2
    translation_delta_cost_weight = 1e-1,
    rotation_delta_cost_weight = 1e-1,
  },

  ceres_scan_matcher = {
    occupied_space_weight_0 = 1.,
    occupied_space_weight_1 = 6.,
    translation_weight = 1.,
    -- IMPACT: YIELDED GOOD TRACKING FOR 270 DEGREE FOV
    rotation_weight = 10,
    -- IMPACT: YIELDED GOOD TRACKING FOR 270 DEGREE FOV
    only_optimize_yaw = false,
    ceres_solver_options = {
      use_nonmonotonic_steps = false,
      max_num_iterations = 12,
      num_threads = 8,
      -- IMPACT: HAS NOT BEEN EVALUATED
    },
  },

  motion_filter = {
    max_time_seconds = 0.5,
    max_distance_meters = 0.1,
    max_angle_radians = 0.004,
  },

  imu_gravity_time_constant = 9.8,
    -- SET BASED UPON IMU CALIBRATION PRINT STATEMENT
    -- IMPACT: HAS NOT BEEN EVALUATED
  rotational_histogram_size = 120,

  submaps = {
    high_resolution = 0.10,
    high_resolution_max_range = 20.,
    low_resolution = 0.45,
    num_range_data = 160,
    range_data_inserter = {
      hit_probability = 0.55,
      miss_probability = 0.49,
      num_free_space_voxels = 2,
    },
  },
}
